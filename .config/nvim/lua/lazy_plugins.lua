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
		"RRethy/vim-illuminate",
		cond = not vim.g.vscode,
	},
	{
		"f-person/git-blame.nvim",
		cond = not vim.g.vscode,
	},
	{
		"nvim-lua/plenary.nvim", -- lua function helpers, required for telescope
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
			require("oil").setup({
				view_options = {
					show_hidden = true,
					skip_confirm_for_simple_edits = true,
				},
			})
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
		cond = not vim.g.vscode,
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
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", "source_name", gap = 1 },
						},
						components = {
							label_description = {
								width = { max = 60 },
								text = function(ctx)
									if ctx.item.detail then
										return ctx.item.detail
									end

									return ""
								end,
								highlight = "BlinkCmpLabelDescription",
							},
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
		"RileyGabrielson/tmux-status.nvim",
		branch = "custom-list-window-format",
		lazy = true,
		opts = {
			manage_tmux_status = false,
			window = {
				text = "index_and_name",
				separator = "  ",
			},
			session = {
				icon = "",
			},
			colors = {
				session = "grey",
				window_active = "#D79921",
				window_inactive = "grey",
				window_inactive_recent = "grey",
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
		"mfussenegger/nvim-dap",
		config = function()
			require("config.dap-js")
		end,
		cond = not vim.g.vscode,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
		cond = not vim.g.vscode,
	},
}

return plugins
