local stdpath = vim.fn.stdpath("data") .. "/mason/bin/"
local typescript_format = { "biome", stop_after_first = true }

local M = {
	auto_formatting = true,
}

function M.toggle_auto_formatting()
	M.auto_formatting = not M.auto_formatting
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
		typst = { "prettypst" },
		json = { "fixjson" },
	},
	formatters = {
		fixjson = {
			command = stdpath .. "fixjson",
		},
		prettier = {
			command = stdpath .. "prettier",
		},
		stylua = {
			command = stdpath .. "stylua",
		},
		biome = {
			command = stdpath .. "biome",
		},
		gofumpt = {
			command = stdpath .. "gofumpt",
		},
		prettypst = {
			command = stdpath .. "prettypst",
			args = { "--use-std-in", "--use-std-out" },
		},
	},
})

return M
