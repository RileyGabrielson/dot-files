local function restart_lsp()
	vim.cmd("w")
	vim.lsp.stop_client(vim.lsp.get_clients())
	vim.cmd("e")
end

return restart_lsp
