local harpoon_tmux = require("harpoon.tmux")

local presenterm = function()
	local root_path = vim.fn.getcwd() .. "/"
	local file_path = vim.api.nvim_buf_get_name(0)
	local trimmed_path = file_path:sub(string.len(root_path) + 1, string.len(file_path))

	harpoon_tmux.sendCommand(1, "present " .. trimmed_path .. "\n")
	harpoon_tmux.gotoTerminal(1)
end

return presenterm
