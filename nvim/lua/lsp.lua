local stdpath = vim.fn.stdpath("data") .. "/mason/bin/"

-- ESLINT
vim.lsp.config.eslint = {
	cmd = { stdpath .. "vscode-eslint-language-server", "--stdio" },
	root_markers = { "package.json" },
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	settings = {
		nodePath = "",
		experimental = {
			useFlatConfig = false,
		},
	},
}

-- GO
vim.lsp.config.gopls = {
	cmd = { stdpath .. "gopls" },
	root_markers = { ".git" },
	filetypes = { "go" },
}

-- TYPESCRIPT
vim.lsp.config.ts_ls = {
	cmd = { stdpath .. "typescript-language-server", "--stdio" },
	root_markers = { "package.json" },
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
}

-- LUA
vim.lsp.config.lua_ls = {
	cmd = { stdpath .. "lua-language-server" },
	root_markers = { ".git" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
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
	root_markers = { "project.godot" },
	filetypes = { "gdscript" },
}

-- CPAT
vim.filetype.add({
	extension = {
		cpat = "cpat",
	},
})
vim.lsp.config.cpat = {
	cmd = { "bun", "run", "/Users/riley.gabrielson/r/cpat-extension/src/server/server.ts", "--stdio" },
	root_markers = { "package.json" },
	filetypes = { "cpat" },
}

-- RUST
vim.lsp.config.rust_analyzer = {
	cmd = { stdpath .. "rust-analyzer" },
	root_markers = { ".git" },
	filetypes = { "rust" },
	single_file_support = true,
}

-- BASH
vim.lsp.config.bash = {
  cmd = { stdpath .. "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
}

vim.lsp.enable({ "eslint", "gopls", "ts_ls", "lua_ls", "gdscript", "cpat", "rust_analyzer", "bash" })
