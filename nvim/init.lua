require "plugins"
require "keybinds"
require "options"
require "autocmd"

require'lspconfig'.tsserver.setup {
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},

    on_attach = function(_, bufnr)
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

require'lspconfig'.sumneko_lua.setup {
  on_attach = function(_, bufnr)
    require "lsp_signature".on_attach({
      bind = true,
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
  end,

  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


