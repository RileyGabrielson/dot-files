local servers = {
  "lua_ls",
  "cssls",
  "html",
  "ts_ls",
  "eslint",
  "omnisharp",
  "rust_analyzer",
}

local settings = {
  ui = {
    border = "none",
  },
  log_level = vim.log.levels.ERROR,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup {
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {}
  server = vim.split(server, "@")[1]
  lspconfig[server].setup(opts)
end

-- require'ts_ls'.setup {
--   server = {
--     filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},
--     root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
--     settings = { documentFormatting = false },
--     init_options = {
--       preferences = {
--         importModuleSpecifierPreference = "non-relative",
--       },
--     },
--     handlers = {
--         ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--             virtual_text = true,
--             signs = true,
--             underline = true,
--             update_in_insert = false,
--         })
--     },
--   }
-- }
