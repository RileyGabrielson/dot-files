local harpoon_tmux = require('harpoon.tmux')
local function cover_file()
  local file_path = vim.api.nvim_buf_get_name(0);
  local trimmed_path = file_path:gsub("/Users/riley.gabrielson/r/neo/ui/operator/", "")
  trimmed_path = trimmed_path:gsub("/Users/riley.gabrielson/r/neo/commons/ui/", "")
  local test_path = trimmed_path:gsub("/__tests__", "")
  test_path = test_path:gsub(".test", "")

  local test_details = file_path .. ' --coverage --collectCoverageFrom=\'' .. test_path .. '\'' .. '\n'
  return test_details
end

local test_neo = {
  cover_operator = function()
    local test_details = cover_file()
    harpoon_tmux.sendCommand(2, "yarn operator test " .. test_details)
  end,

  cover_commons = function()
    local test_details = cover_file()
    harpoon_tmux.sendCommand(2, "yarn commons test " .. test_details)
  end,
}

return test_neo
