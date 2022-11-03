require"dapui".setup({
  layouts = {
    {
      elements = {
        "scopes"
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
      },
      size = 0.1,
      position = "bottom",
    },
  },
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
