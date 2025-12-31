local function command_exists(name)
	return vim.fn.exists(":" .. name) == 2
end

local go_to_definition = function()
	if command_exists("LspTypescriptGoToSourceDefinition") then
		vim.cmd("LspTypescriptGoToSourceDefinition")
		return
	end

	vim.lsp.buf.definition()
end

return go_to_definition
