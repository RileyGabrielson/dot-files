---@diagnostic disable: missing-fields
local plugins = {
	{
		"ellisonleao/gruvbox.nvim",
	},
	{
		"svermeulen/vimpeccable", -- mapping keybinds to lua functions
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("config.conform")
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end,
	},
	{
		"chrisgrieser/nvim-recorder",
		config = function()
			require("recorder").setup({})
		end,
	},
	{
		"terrortylor/nvim-comment",
		config = function()
			require("config.comment")
		end,
	},
	{
		"nvim-lua/plenary.nvim", -- lua function helpers, required for telescope
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("config.harpoon")
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"RRethy/vim-illuminate",
		cond = not vim.g.vscode,
	},
	{
		"f-person/git-blame.nvim",
		cond = not vim.g.vscode,
	},
	{
		"nvim-treesitter/playground",
		cond = not vim.g.vscode,
	},
	{
		"mbbill/undotree",
		cond = not vim.g.vscode,
	},
	{
		"unblevable/quick-scope", -- highlighting f and t jumping
		cond = not vim.g.vscode,
	},
	{
		"habamax/vim-godot",
		cond = not vim.g.vscode,
	},
	{
		"kyazdani42/nvim-web-devicons",
		cond = not vim.g.vscode,
	},

	{
		"echasnovski/mini.icons",
		version = false,
		cond = not vim.g.vscode,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		cond = not vim.g.vscode,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.gitsigns")
		end,
		cond = not vim.g.vscode,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		cmd = "Trouble",
		opts = {},
		cond = not vim.g.vscode,
	},

	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.oil")
		end,
		cond = not vim.g.vscode,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		cond = not vim.g.vscode,
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			require("config.harpoon")
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
		cond = not vim.g.vscode,
	},

	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("config.diffview")
		end,
		cond = not vim.g.vscode,
	},

	{
		"folke/noice.nvim",
		config = function()
			require("config.noice")
		end,
		dependencies = { "MunifTanjim/nui.nvim" },
		cond = not vim.g.vscode,
	},

	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({})
		end,
		cond = not vim.g.vscode,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "RileyGabrielson/tmux-status.nvim" },
		config = function()
			require("config.lualine")
		end,
		cond = not vim.g.vscode,
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("config.mason")
		end,
		cond = not vim.g.vscode,
	},

	{
		"saghen/blink.cmp",
		version = "1.*",
		opts_extend = { "sources.default" },
		opts = {
			keymap = {
				preset = "default",
				["<C-space>"] = { "select_and_accept" },
			},
			completion = {
				menu = {
					draw = {
						columns = {
							{ "label", gap = 1 },
							{ "kind_icon", "kind", "source_name", gap = 1 },
						},
						components = {
							-- label_description = {
							-- 	width = { max = 60 },
							-- 	text = function(ctx)
							-- 		if ctx.item.detail then
							-- 			return ctx.item.detail
							-- 		end

							-- 		return ""
							-- 	end,
							-- 	highlight = "BlinkCmpLabelDescription",
							-- },
						},
					},
				},
			},
		},
		cond = not vim.g.vscode,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
		cond = not vim.g.vscode,
	},

	{
		"RileyGabrielson/inspire.nvim",
		config = function()
			require("inspire").setup({})
		end,
		cond = not vim.g.vscode,
	},

	{
		"christopher-francisco/tmux-status.nvim",
		lazy = false,
		opts = {
			manage_tmux_status = false,
			window = {
				text = "index_and_name",
				separator = "  ",
			},
			session = {
				icon = " ",
			},
			colors = {
				session = { fg = "#bbbbbb", bg = "#5f5f5f" },
				window_active = { fg = "#d7b000", bg = "#4e4e4e" },
				window_inactive = { fg = "#bbbbbb", bg = "#4e4e4e" },
				window_inactive_recent = { fg = "#bbbbbb", bg = "#4e4e4e" },
			},
		},
		cond = not vim.g.vscode,
	},

	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.fzf")
		end,
		cond = not vim.g.vscode,
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "echasnovski/mini.icons", "RileyGabrielson/inspire.nvim" },
		config = function()
			require("config.alpha")
		end,
		cond = not vim.g.vscode,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
	},

	{
		"chomosuke/typst-preview.nvim",
		lazy = false,
		opts = {
			invert_colors = "true",
			dependencies_bin = {
				["tinymist"] = "tinymist",
			},
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup({
				softener = { markdown = true, typst = true },
			})
		end,
	},

	-- {
	-- 	"yetone/avante.nvim",
	-- 	build = "make",
	-- 	event = "VeryLazy",
	-- 	version = false, -- Never set this value to "*"! Never!
	-- 	opts = {
	-- 		provider = "gemini",
	-- 	},
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"ibhagwan/fzf-lua", -- for file_selector provider fzf
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- },
}

return plugins
