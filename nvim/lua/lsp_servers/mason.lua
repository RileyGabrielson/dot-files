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
