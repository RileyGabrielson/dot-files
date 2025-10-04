local status_column = {}

status_column.initial_padding = function()
	return " "
end

status_column.line_number = function()
	local total_lines = vim.api.nvim_buf_line_count(0)
	local padding_width = string.len(tostring(total_lines))

	if vim.v.relnum == 0 then
		return table.concat({
			[[%#CursorLineNumber#]],
			string.format("%" .. padding_width .. "d", vim.v.lnum),
		})
	end

	return table.concat({
		[[%#DefaultLineNumber#]],
		string.format("%" .. padding_width .. "d", vim.v.relnum),
	})
end

status_column.spacing = function()
	return " "
end

status_column.border = function()
	if vim.v.relnum == 0 then
		return table.concat({
			[[%#CursorLineNumber#]],
			[[▐]],
		})
	end

	return table.concat({
		[[%#StatusColumnBorder#]],
		[[▐]],
	})
end

status_column.end_padding = function()
	return " "
end

status_column.myStatuscolumn = function()
	local text = ""
	text = table.concat({
		status_column.initial_padding(),
		status_column.line_number(),
		status_column.spacing(),
		status_column.border(),
		status_column.end_padding(),
	})

	return text
end

vim.o.statuscolumn = "%!v:lua.require('status_column').myStatuscolumn()"

return status_column
