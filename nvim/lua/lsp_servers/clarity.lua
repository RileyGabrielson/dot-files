local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.set_log_level("info")

vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {"*.cpat"},
    callback = function()
      print('start')
      vim.lsp.start {
          name = "clarity-pattern-parser",
          root_dir = vim.fs.dirname(vim.fs.find({'package.json',}, { upward = true })[1]),
          cmd = {
              "bun", "run",
              "/Users/riley.gabrielson/r/cpat-extension/src/server/server.ts",
              "--stdio"
          },
          capabilities = capabilities
      }
    end
})
