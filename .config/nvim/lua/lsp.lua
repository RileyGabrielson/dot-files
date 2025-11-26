local stdpath = vim.fn.stdpath("data") .. "/mason/bin/"

-- BIOME
vim.lsp.config.biome = {
	cmd = { stdpath .. "biome", "lsp-proxy" },
	root_markers = { "biome.json" },
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	single_file_support = false,
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
	root_markers = { "tsconfig.json" },
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	init_options = {
		hostInfo = "neovim",
		preferences = {
			includeCompletionsForModuleExports = true,
			includeCompletionsForImportStatements = true,
			importModuleSpecifierPreference = "non-relative",
		},
	},
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
	cmd = { "bun", "run", "/Users/riley.gabrielson/r/work-other/cpat-extension/src/server/server.ts", "--stdio" },
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

-- TYPST
vim.lsp.config.typst = {
	cmd = { stdpath .. "tinymist" },
	filetypes = { "typst" },
}

-- GODOT

local port = os.getenv("GDScript_Port") or "6008"
local cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(port))

vim.lsp.config.godot = {
	cmd = cmd,
	filetypes = { "gd", "gdscript", "gdscript3" },
	root_markers = { "project.godot", ".git" },
}

vim.lsp.enable({
	"gopls",
	"ts_ls",
	"biome",
	"ts_ls",
	"lua_ls",
	"gdscript",
	"cpat",
	"rust_analyzer",
	"bash",
	"typst",
	"godot",
})
