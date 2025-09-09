local function cycle_todo_status()
	local line = vim.api.nvim_get_current_line()
	local line_num = vim.api.nvim_win_get_cursor(0)[1]
	local new_line = ""

	-- Get the indentation (spaces/tabs at the beginning)
	local indent = line:match("^%s*")
	local content = line:sub(#indent + 1)

	-- Case 1: Line doesn't start with '-'
	if not content:match("^%-") then
		new_line = indent .. "- " .. content
	-- Case 2: Line starts with '-' but is not a checkbox
	elseif content:match("^%-") and not content:match("^%- %[[ x]%]") then
		-- Remove the existing '- ' and add '- [ ] '
		local text_content = content:gsub("^%-%s*", "")
		new_line = indent .. "- [ ] " .. text_content
	-- Case 3: Line is already a checkbox - toggle between [ ] and [x]
	elseif content:match("^%- %[ %]") then
		-- Change [ ] to [x]
		new_line = line:gsub("%- %[ %]", "- [x]")
	elseif content:match("^%- %[x%]") then
		-- Change [x] to [ ]
		new_line = line:gsub("%- %[x%]", "- [ ]")
	else
		-- Fallback - shouldn't reach here, but just in case
		new_line = line
	end

	-- Update the line
	vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { new_line })

	-- Move cursor to the end of the line
	local new_line_length = #new_line
	vim.api.nvim_win_set_cursor(0, { line_num, new_line_length })
end

return cycle_todo_status
