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
      diagnostics = {
        globals = {'vim'},
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
