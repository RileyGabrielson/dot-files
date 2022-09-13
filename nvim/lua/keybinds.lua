local vimp = require('vimp')
local toggle_term = require('toggleterm')
local function cover_file()
  local file_path = vim.api.nvim_buf_get_name(0);
  local trimmed_path = file_path:gsub("/Users/riley.gabrielson/r/neo/ui/operator/", "")
  trimmed_path = trimmed_path:gsub("/Users/riley.gabrielson/r/neo/commons/ui/", "")
  local test_path = trimmed_path:gsub("/__tests__", "")
  test_path = test_path:gsub(".test", "")

  local test_details = file_path .. ' --coverage --collectCoverageFrom=\'' .. test_path .. '\''
  return test_details
end

vimp.nnoremap('<leader>co', function()
  local test_details = cover_file()
  toggle_term.exec("yarn operator test " .. test_details)
end)

vimp.nnoremap('<leader>cc', function()
  local test_details = cover_file()
  toggle_term.exec("yarn commons test " .. test_details)
end)


