local treesitter = require("nvim-treesitter")

treesitter.install({
	"typescript",
	"javascript",
	"c_sharp",
	"lua",
	"vim",
	"regex",
	"bash",
	"markdown",
	"markdown_inline",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
	callback = function(args)
		local language = vim.treesitter.language.get_lang(args.match)
		if not language or not vim.list_contains(treesitter.get_available(), language) then
			return
		end
		treesitter.install(language):await(function()
			vim.schedule(function()
				if vim.api.nvim_buf_is_valid(args.buf) then
					pcall(vim.treesitter.start, args.buf, language)
				end
			end)
		end)
	end,
})
