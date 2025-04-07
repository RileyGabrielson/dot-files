local get_verse = function()
	vim.ui.input({ prompt = "Verse (ex Alma 32:30): " }, function(input)
		if input == nil then
			return
		end

		local command = "~/verse " .. input
		vim.fn.jobstart(command, {
			on_stdout = function(j, d)
				local output = vim.fn.join(d)
				local pos = vim.api.nvim_win_get_cursor(0)[2]
				local line = vim.api.nvim_get_current_line()
				local nline = line:sub(0, pos) .. output .. line:sub(pos + 1)
				vim.api.nvim_set_current_line(nline)
			end,
		})
	end)
end

return get_verse
