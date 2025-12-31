local stdpath = vim.fn.stdpath("data") .. "/mason/bin/"

-- BIOME
vim.lsp.config.biome = {
	cmd = { stdpath .. "biome", "lsp-proxy" },
	root_markers = { "biome.json" },
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	single_file_support = false,
}

-- GO
vim.lsp.config.go = {
	cmd = { stdpath .. "gopls" },
	root_markers = { ".git" },
	filetypes = { "go" },
}

-- TYPESCRIPT
-- vim.lsp.config.typescript = {
-- 	cmd = function(dispatchers)
-- 		return vim.lsp.rpc.start({ stdpath .. "tsgo", "--lsp", "--stdio" }, dispatchers)
-- 	end,
-- 	root_markers = { "tsconfig.json", "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" },
-- 	filetypes = {
-- 		"javascript",
-- 		"javascriptreact",
-- 		"javascript.jsx",
-- 		"typescript",
-- 		"typescriptreact",
-- 		"typescript.tsx",
-- 	},
-- }

vim.lsp.config.typescript = {
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
	on_attach = function(client, bufnr)
		-- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
		-- `vim.lsp.buf.code_action()` if specified in `context.only`.
		vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
			local source_actions = vim.tbl_filter(function(action)
				return vim.startswith(action, "source.")
			end, client.server_capabilities.codeActionProvider.codeActionKinds)

			vim.lsp.buf.code_action({
				context = {
					only = source_actions,
					diagnostics = {},
				},
			})
		end, {})

		-- Go to source definition command
		vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptGoToSourceDefinition", function()
			local win = vim.api.nvim_get_current_win()
			local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
			client:exec_cmd({
				command = "_typescript.goToSourceDefinition",
				title = "Go to source definition",
				arguments = { params.textDocument.uri, params.position },
			}, { bufnr = bufnr }, function(err, result)
				if err then
					vim.notify("Go to source definition failed: " .. err.message, vim.log.levels.ERROR)
					return
				end
				if not result or vim.tbl_isempty(result) then
					vim.notify("No source definition found", vim.log.levels.INFO)
					return
				end
				vim.lsp.util.show_document(result[1], client.offset_encoding, { focus = true })
			end)
		end, { desc = "Go to source definition" })
	end,
}

-- LUA
vim.lsp.config.lua = {
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
vim.lsp.config.rust = {
	cmd = { stdpath .. "rust-analyzer" },
	root_markers = { ".git" },
	filetypes = { "rust" },
	single_file_support = true,
}

-- Proto
vim.lsp.config.proto = {
	cmd = { stdpath .. "buf", "lsp", "serve", "--log-format=text" },
	root_markers = { "buf.yaml", ".git" },
	filetypes = { "proto" },
	reuse_client = function(client, config)
		-- `buf lsp serve` is meant to be used with multiple workspaces.
		return client.name == config.name
	end,
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
	"go",
	"typescript",
	"biome",
	"lua",
	"cpat",
	"rust",
	"proto",
	"typst",
	"godot",
})
