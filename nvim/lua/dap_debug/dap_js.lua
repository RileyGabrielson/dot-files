local dap = require("dap")

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/"},
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  require("dap").configurations[language] = {
    {
      name = 'Launch Node',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
  }
end

require("mason-nvim-dap").setup({
    ensure_installed = { "node2" }
})
