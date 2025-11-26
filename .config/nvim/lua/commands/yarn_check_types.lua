-- Function to process the command result and populate quickfix
local function process_result(result, cwd, notify_id)
	-- Dismiss loading notification
	local notify = require("notify")
	notify.dismiss(notify_id)

	-- Parse the output (TypeScript errors can be in stdout or stderr)
	-- Combine both outputs
	local output = result.stdout or ""
	if result.stderr and #result.stderr > 0 then
		if #output > 0 then
			output = output .. "\n" .. result.stderr
		else
			output = result.stderr
		end
	end

	-- If command failed (non-zero exit) but no output, there might be an issue
	if result.code ~= 0 and #output == 0 then
		vim.notify("Command failed with exit code " .. result.code .. " but produced no output", vim.log.levels.ERROR, {
			title = "Type Check",
		})
		return
	end

	-- Parse the output
	local quickfix_items = {}
	local lines = vim.split(output, "\n", { plain = true, trimempty = false })

	-- Pattern to match TypeScript error format
	-- Format 1: filepath(line,col): error TS####: message
	-- Example: src/app/.../file.ts(40,7): error TS2345: Argument of type...
	local error_pattern_parens = "^([^(]+)%((%d+),(%d+)%):%s+error%s+TS%d+:%s+(.+)$"
	-- Format 2: filepath:line:col - error TS####: message (alternative format)
	-- Example: src/app/.../file.ts:40:7 - error TS2345: Argument of type...
	local error_pattern_colons = "^([^:]+):(%d+):(%d+)%s+-%s+error%s+TS%d+:%s+(.+)$"
	local code_context_pattern = "^%s*%d+%s+" -- Matches lines starting with line numbers (code context)
	local found_error_pattern = "^Found%s+%d+%s+error" -- Matches "Found X error" summary lines

	local i = 1
	while i <= #lines do
		local line = lines[i]

		-- Skip summary lines like "Found 1 error in file:line"
		if line:match(found_error_pattern) then
			i = i + 1
			goto continue
		end

		-- Try to match error line (try parentheses format first, then colons format)
		local filename, line_num, col_num, message_start = line:match(error_pattern_parens)
		if not filename then
			filename, line_num, col_num, message_start = line:match(error_pattern_colons)
		end
		if filename then
			-- Trim filename (remove trailing spaces)
			filename = filename:match("^%s*(.-)%s*$")

			-- Collect multi-line error message
			local message_parts = { message_start }
			i = i + 1

			-- Continue reading lines until we hit:
			-- 1. A blank line followed by code context
			-- 2. A "Found X error" summary line
			-- 3. Another error line
			-- 4. End of output
			while i <= #lines do
				local next_line = lines[i]

				-- Stop if we hit another error line
				if next_line:match(error_pattern_parens) or next_line:match(error_pattern_colons) then
					break
				end

				-- Stop if we hit a summary line
				if next_line:match(found_error_pattern) then
					break
				end

				-- Stop if we hit code context (line starting with number and spaces)
				if next_line:match(code_context_pattern) then
					-- Skip the code context line and the caret line that follows
					i = i + 1
					if i <= #lines and lines[i]:match("^%s*~+%s*$") then
						i = i + 1 -- Skip caret line
					end
					-- Skip blank line after code context if present
					if i <= #lines and lines[i]:match("^%s*$") then
						i = i + 1
					end
					break
				end

				-- Stop if we hit a blank line (might be separator between errors)
				if next_line:match("^%s*$") then
					i = i + 1
					break
				end

				-- Add continuation line to message (trim leading whitespace)
				local trimmed = next_line:match("^%s*(.+)$")
				if trimmed then
					table.insert(message_parts, trimmed)
				end
				i = i + 1
			end

			-- Combine message parts
			local full_message = table.concat(message_parts, " ")

			-- Make filename absolute if it's relative
			local abs_filename = filename
			if not vim.startswith(filename, "/") then
				abs_filename = cwd .. "/" .. filename
			end

			table.insert(quickfix_items, {
				filename = abs_filename,
				lnum = tonumber(line_num),
				col = tonumber(col_num),
				text = full_message,
				type = "E", -- Error type
			})
		else
			i = i + 1
		end

		::continue::
	end

	-- Populate quickfix list
	if #quickfix_items > 0 then
		vim.fn.setqflist(quickfix_items, "r")
		vim.cmd("copen")
		vim.notify(string.format("Found %d type error(s)", #quickfix_items), vim.log.levels.WARN, {
			title = "Type Check",
		})
	else
		-- If command failed but we found no errors, show a warning
		if result.code ~= 0 then
			vim.fn.setqflist({}, "r")
			-- Show first few lines of output for debugging
			local preview_lines = {}
			for i = 1, math.min(5, #lines) do
				if lines[i] and #lines[i] > 0 then
					table.insert(preview_lines, lines[i])
				end
			end
			local preview = table.concat(preview_lines, "\n")
			vim.notify(
				"Command failed but no errors parsed. Exit code: " .. result.code .. "\nOutput preview:\n" .. preview,
				vim.log.levels.WARN,
				{
					title = "Type Check",
					timeout = 10000,
				}
			)
		else
			vim.fn.setqflist({}, "r")
			vim.notify("No type errors found!", vim.log.levels.INFO, {
				title = "Type Check",
				icon = "✓",
			})
		end
	end
end

-- Main function that starts the async command
local yarn_check_types = function()
	local cwd = vim.fn.getcwd()
	local package_json_path = cwd .. "/package.json"

	-- Read package.json to find the script name
	local package_json_content = vim.fn.readfile(package_json_path)
	local package_json_text = table.concat(package_json_content, "\n")
	local package_json = vim.json.decode(package_json_text)

	if not package_json or not package_json.scripts then
		vim.notify("No scripts found in package.json", vim.log.levels.ERROR)
		return
	end

	-- Check for check-types or check:types script
	local script_name = nil
	if package_json.scripts["check-types"] then
		script_name = "check-types"
	elseif package_json.scripts["check:types"] then
		script_name = "check:types"
	else
		vim.notify("Neither 'check-types' nor 'check:types' script found in package.json", vim.log.levels.ERROR)
		return
	end

	-- Show loading notification
	local notify_id = vim.notify("Running yarn " .. script_name .. "...", vim.log.levels.INFO, {
		title = "Type Check",
		timeout = false,
		icon = "⏳",
	})

	-- Run the yarn command asynchronously
	vim.system({ "yarn", script_name }, {
		cwd = cwd,
		text = true,
	}, function(result)
		-- This callback runs when the command completes
		-- Schedule UI updates on the main thread
		vim.schedule(function()
			process_result(result, cwd, notify_id)
		end)
	end)
end

return yarn_check_types
