local toggle_term = require'toggleterm'

local start_neo = {
  start_commons_cosmos = function()
    toggle_term.exec_command("cmd='yarn commons start-cosmos' open=0", 2)
  end,

  start_operator = function()
    toggle_term.exec_command("cmd='yarn operator start' open=0", 3)
  end,

  start_operator_cosmos = function()
    toggle_term.exec_command("cmd='yarn operator start-cosmos' open=0", 4)
  end,
}

return start_neo
