-- Show Yanks
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({ higroup="Visual", timeout=200 })
  augroup END
]])

-- Markdown bullet continuation
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set("i", "<CR>", function()
			local line = vim.api.nvim_get_current_line()

			-- Check for - [x] first (most specific)
			local _, bullet = string.match(line, "^(%s*)(%- %[x%])")
			if bullet then
				return "<CR>" .. "- [ ] "
			end

			-- Check for - [ ] (unchecked checkbox)
			_, bullet = string.match(line, "^(%s*)(%- %[ %])")
			if bullet then
				return "<CR>" .. bullet .. " "
			end

			-- Check for - (regular bullet)
			_, bullet = string.match(line, "^(%s*)(%-)")
			if bullet then
				return "<CR>" .. bullet .. " "
			end

			-- Default behavior: just insert newline
			return "<CR>"
		end, { buffer = true, expr = true })
	end,
})
