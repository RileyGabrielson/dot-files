local stdpath = vim.fn.stdpath('data');
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- ESLINT
vim.lsp.config.eslint = {
  cmd = { stdpath .. '/mason/bin/vscode-eslint-language-server', '--stdio' },
  root_markers = { 'package.json' },
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  settings = {
    nodePath = '',
    experimental = {
      useFlatConfig = false,
    },
  }
}

-- GO
vim.lsp.config.gopls = {
  cmd = { stdpath .. '/mason/bin/gopls' },
  root_markers = { '.git' },
  filetypes = { 'go' }
}

-- TYPESCRIPT
vim.lsp.config.ts_ls = {
  cmd = { stdpath .. '/mason/bin/typescript-language-server', '--stdio' },
  root_markers = { 'package.json' },
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }
}

-- LUA
vim.lsp.config.lua_ls = {
  cmd = { stdpath .. '/mason/bin/lua-language-server' },
  root_markers = { '.git' },
  filetypes = { 'lua' },
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

-- GODOT
vim.lsp.config.gdscript = {
  cmd = vim.lsp.rpc.connect("127.0.0.1", 6008),
  root_markers = { 'project.godot' },
  filetypes = { 'gdscript' },
  capabilities = capabilities
}

-- CPAT
vim.filetype.add({
  extension = {
    cpat = "cpat"
  }
})
vim.lsp.config.cpat = {
  cmd = { "bun", "run", "/Users/riley.gabrielson/r/cpat-extension/src/server/server.ts", "--stdio" },
  root_markers = { 'package.json' },
  filetypes = { 'cpat' },
}

-- RUST
vim.lsp.config.rust_analyzer = {
  cmd = { stdpath .. '/mason/bin/rust-analyzer' },
  root_markers = { '.git' },
  filetypes = { 'rust' },
  single_file_support = true,
}

vim.lsp.enable({ 'eslint', 'gopls', 'ts_ls', 'lua_ls', 'gdscript', 'cpat', 'rust_analyzer' })
