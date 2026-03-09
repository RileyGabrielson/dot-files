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

		-- Tab/Shift+Tab indentation for bullets
		vim.keymap.set("i", "<Tab>", function()
			local line = vim.api.nvim_get_current_line()
			local col = vim.api.nvim_win_get_cursor(0)[2]
			
			-- Check if line starts with a bullet
			if string.match(line, "^%s*%-") then
				local indent = string.match(line, "^(%s*)")
				local indent_len = indent and #indent or 0
				
				-- Modify the line directly
				local new_indent = string.rep(" ", indent_len + 2)
				local rest_of_line = string.sub(line, indent_len + 1)
				local new_line = new_indent .. rest_of_line
				
				local row = vim.api.nvim_win_get_cursor(0)[1] - 1
				vim.api.nvim_buf_set_text(0, row, 0, row, #line, { new_line })
				-- Move cursor to maintain relative position
				vim.api.nvim_win_set_cursor(0, { row + 1, math.min(#new_line, col + 2) })
			else
				-- Default Tab behavior
				vim.fn.feedkeys("<Tab>", "n")
			end
		end, { buffer = true })

		vim.keymap.set("i", "<S-Tab>", function()
			local line = vim.api.nvim_get_current_line()
			local col = vim.api.nvim_win_get_cursor(0)[2]
			
			-- Check if line starts with a bullet
			if string.match(line, "^%s*%-") then
				local indent = string.match(line, "^(%s*)")
				local indent_len = indent and #indent or 0
				
				-- Decrease indent by 2 spaces (but not below 0)
				local new_indent_len = math.max(0, indent_len - 2)
				local new_indent = string.rep(" ", new_indent_len)
				local rest_of_line = string.sub(line, indent_len + 1)
				local new_line = new_indent .. rest_of_line
				
				local row = vim.api.nvim_win_get_cursor(0)[1] - 1
				vim.api.nvim_buf_set_text(0, row, 0, row, #line, { new_line })
				-- Move cursor to maintain relative position
				local cursor_offset = indent_len - new_indent_len
				vim.api.nvim_win_set_cursor(0, { row + 1, math.max(0, col - cursor_offset) })
			else
				-- Default Shift+Tab behavior
				vim.fn.feedkeys("<S-Tab>", "n")
			end
		end, { buffer = true })
	end,
})
