_G.StatusColumn = {
	sections = {
		initial_padding = {
			[[ ]],
		},
		line_number = {
			[[%=%{v:relnum?v:relnum:v:lnum}]],
		},
		spacing = {
			[[ ]],
		},
		border = {
			[[%#StatusColumnBorder#]], -- Highlight Group
			[[▐]],
		},
		end_padding = {
			[[%#WinSeparator#]], -- Highlight Group
			[[ ]],
		},
	},

	build = function(tbl)
		local statuscolumn = {}

		for _, value in ipairs(tbl) do
			if type(value) == "string" then
				table.insert(statuscolumn, value)
			elseif type(value) == "table" then
				table.insert(statuscolumn, StatusColumn.build(value))
			end
		end

		return table.concat(statuscolumn)
	end,
}

vim.opt.statuscolumn = StatusColumn.build({
	StatusColumn.sections.initial_padding,
	StatusColumn.sections.line_number,
	StatusColumn.sections.spacing,
	StatusColumn.sections.border,
	StatusColumn.sections.end_padding,
})
