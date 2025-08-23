local harpoon_tmux = require("harpoon.tmux")
local tinymist_bin = vim.fn.stdpath("data") .. "/mason/bin/tinymist"

local present_slides = function()
	local root_path = vim.fn.getcwd() .. "/"
	local file_path = vim.api.nvim_buf_get_name(0)
	local trimmed_path = file_path:sub(string.len(root_path) + 1, string.len(file_path))

	harpoon_tmux.sendCommand(1, tinymist_bin .. " preview " .. trimmed_path .. " --preview-mode=slide" .. "\n")
	harpoon_tmux.gotoTerminal(1)
end

return present_slides
