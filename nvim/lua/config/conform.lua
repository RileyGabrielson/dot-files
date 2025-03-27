local stdpath = vim.fn.stdpath("data")
local typescript_format = { "prettier", stop_after_first = true }

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
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
