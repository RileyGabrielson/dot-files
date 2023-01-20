local diagnostics_active = true

local toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end

local M = {}
M.toggle_diagnostics = toggle_diagnostics

return M
