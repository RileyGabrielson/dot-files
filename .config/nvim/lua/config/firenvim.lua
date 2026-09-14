-- Firenvim runs neovim inside browser textareas.
-- Press <C-e> in a textarea to take over, then :w to sync back to the page.
vim.g.firenvim_config = {
	globalSettings = {
		alt = "all",
	},
	localSettings = {
		[".*"] = {
			cmdline = "neovim",
			content = "text",
			priority = 0,
			-- firenvim's default. Widen per-site below if a page uses a
			-- contenteditable div instead of a real textarea.
			selector = 'textarea:not([readonly], [aria-readonly]), div[role="textbox"]',
			takeover = "never",
		},
	},
}

if not vim.g.started_by_firenvim then
	return
end

vim.opt.laststatus = 0
vim.opt.showtabline = 0
vim.opt.cmdheight = 0

-- Browser textareas are small: drop the gutter and soft wrap.
-- Runs on BufEnter so it wins over wrapping.nvim's filetype defaults.
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("firenvim_buffers", { clear = true }),
	callback = function(args)
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.foldcolumn = "0"
		vim.wo.signcolumn = "no"
		vim.wo.wrap = true
		vim.wo.linebreak = true

		local name = vim.fs.basename(vim.api.nvim_buf_get_name(args.buf))
		if name:match("^github%.com_") or name:match("^gitlab") or name:match("^git%.tcncloud%.net_") then
			vim.bo[args.buf].filetype = "markdown"
		end
	end,
})

-- <C-z> hands the textarea back to the browser.
vim.keymap.set({ "n", "i" }, "<C-z>", "<Cmd>call firenvim#focus_page()<CR>")
