require "plugins"
require "keybinds"
require "options"
require "autocmd"

require'lspconfig'.tsserver.setup {
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},

    on_attach = function(client, bufnr)
      require "lsp_signature".on_attach({
        bind = true,
        handler_opts = {
          border = "rounded"
        }
      }, bufnr)
    end,

    root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    settings = {documentFormatting = true},
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = {spacing = 0, prefix = "*"},
            signs = true,
            underline = true,
            update_in_insert = true
        })
    },
}

