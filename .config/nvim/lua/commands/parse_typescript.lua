local buffer_number = -1

local function log(_, data, index)
	if data then
		-- Make it temporarily writable so we don't have warnings.
		vim.api.nvim_buf_set_option(buffer_number, "readonly", false)

		-- Append the data.
		vim.api.nvim_buf_set_lines(buffer_number, index, index, true, data)

		-- Make readonly again.
		vim.api.nvim_buf_set_option(buffer_number, "readonly", true)

		-- Mark as not modified, otherwise you'll get an error when
		-- attempting to exit vim.
		vim.api.nvim_buf_set_option(buffer_number, "modified", false)

		-- Get the window the buffer is in and set the cursor position to the bottom.
		local buffer_window = vim.api.nvim_call_function("bufwinid", { buffer_number })
		local buffer_line_count = vim.api.nvim_buf_line_count(buffer_number)
		vim.api.nvim_win_set_cursor(buffer_window, { buffer_line_count, 0 })
	end
end

local function open_buffer()
	-- Get a boolean that tells us if the buffer number is visible anymore.
	--
	-- :help bufwinnr
	local buffer_visible = vim.api.nvim_call_function("bufwinnr", { buffer_number }) ~= -1

	if buffer_number == -1 or not buffer_visible then
		-- Create a new buffer with the name "TYPESCRIPT_OUTPUT".
		-- Same name will reuse the current buffer.
		vim.api.nvim_command("botright vsplit TYPESCRIPT_OUTPUT")

		-- Collect the buffer's number.
		buffer_number = vim.api.nvim_get_current_buf()

		-- Mark the buffer as readonly.
		vim.opt_local.readonly = true
	end
end

local buffer_to_string = function()
	local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
	return table.concat(content, "\n")
end

local function display_typescript(pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = pattern,
		callback = function()
			local text = buffer_to_string()
			local count = 0
			local lines = {}
			for s in text:gmatch("[^\r\n]+") do
				table.insert(lines, s)
				count = count + 1
			end

			-- Open our buffer, if we need to.
			open_buffer()

			-- Clear the buffer's contents incase it has been used.
			vim.api.nvim_buf_set_lines(buffer_number, 0, -1, true, {})

			local commands = {}

			for i, line in ipairs(lines) do
				-- Run the command.
				local truncated = ""
				for j, line_2 in ipairs(lines) do
					if j < i then
						truncated = truncated .. line_2
					end
					if j == i then
						truncated = truncated .. "console.log(" .. string.gsub(line_2, ";", "") .. ");"
					end
				end

				local function log_at(_, data)
					log(nil, data, i)
				end

				vim.fn.jobstart({ "deno", "eval", truncated }, {
					stdout_buffered = true,
					on_stdout = log_at,
					on_stderr = log_at,
				})
			end
		end,
	})
end

-- display_typescript("*.ts", { "deno", "eval", 'console.log(2+2); console.log(5)'})
