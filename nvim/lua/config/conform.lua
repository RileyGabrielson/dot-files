local stdpath = vim.fn.stdpath("data")
local typescript_format = { "biome", stop_after_first = true }

local M = {
	auto_formatting = true,
}

function M.toggle_auto_formatting()
	M.auto_formatting = not M.auto_formatting
	print(M.auto_formatting)
end

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if M.auto_formatting then
			require("conform").format({ bufnr = args.buf })
		end
	end,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = typescript_format,
		javascriptreact = typescript_format,
		typescript = typescript_format,
		typescriptreact = typescript_format,
		go = { "gofumpt" },
	},
	formatters = {
		prettier = {
			command = stdpath .. "/mason/bin/prettier",
		},
		stylua = {
			command = stdpath .. "/mason/bin/stylua",
		},
		biome = {
			command = stdpath .. "/mason/bin/biome",
		},
		gofumpt = {
			command = stdpath .. "/mason/bin/gofumpt",
		},
	},
})

return M
