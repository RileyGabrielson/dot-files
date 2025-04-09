local harpoon_tmux = require("harpoon.tmux")

local function get_test_details()
	local root_path = vim.fn.getcwd() .. "/"
	local file_path = vim.api.nvim_buf_get_name(0)
	local trimmed_path = file_path:sub(string.len(root_path) + 1, string.len(file_path))
	local coverage_path = trimmed_path:gsub("/__tests__", "")
	coverage_path = coverage_path:gsub(".test", "")

	-- local test_details = file_path .. " --coverage --collectCoverageFrom='" .. coverage_path .. "'" .. "\n"
	local test_details = file_path .. " --coverage --coverage.include=" .. coverage_path .. "\n"
	return test_details
end

local jest_coverage = function()
	local test_details = get_test_details()
	harpoon_tmux.sendCommand(1, "yarn test " .. test_details)
	harpoon_tmux.gotoTerminal(1)
end

return jest_coverage
