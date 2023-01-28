local servers = {
  "sumneko_lua",
  "cssls",
  "html",
  "tsserver",
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
  ensure_installed = servers,
  automatic_installation = true,
}
require("mason-nvim-dap").setup({
  ensure_installed = {"node2"},
  automatic_installation = true,
  automatic_setup = true,
})


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

