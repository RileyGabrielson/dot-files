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

local cover_operator = function()
  local test_details = cover_file()
  harpoon_tmux.sendCommand(1, "yarn operator test " .. test_details)
  harpoon_tmux.gotoTerminal(1)
end

local cover_commons = function()
  local test_details = cover_file()
  harpoon_tmux.sendCommand(1, "yarn commons test " .. test_details)
  harpoon_tmux.gotoTerminal(1)
end

local test_neo = {
  cover_neo = function()
    local file_path = vim.api.nvim_buf_get_name(0);
    if string.find(file_path, "commons/ui") then
      cover_commons()
    end
    if string.find(file_path, "ui/operator") then
      cover_operator()
    end
  end
}

return test_neo
