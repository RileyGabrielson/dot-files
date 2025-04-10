local plugins = {
	"RRethy/vim-illuminate",
	"f-person/git-blame.nvim",
	"svermeulen/vimpeccable", -- mapping keybinds to lua functions
	"nvim-lua/plenary.nvim", -- lua function helpers, required for telescope
	"nvim-treesitter/playground",
	"mbbill/undotree",
	"unblevable/quick-scope", -- highlighting f and t jumping
	"JoosepAlviste/nvim-ts-context-commentstring",
	"habamax/vim-godot",
	"ellisonleao/gruvbox.nvim",
	"kyazdani42/nvim-web-devicons",

	{ "echasnovski/mini.icons", version = false },

	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.gitsigns")
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		cmd = "Trouble",
		opts = {},
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
	},

	{
		"terrortylor/nvim-comment",
		config = function()
			require("config.comment")
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
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
	},

	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("config.diffview")
		end,
	},

	{
		"chrisgrieser/nvim-recorder",
		config = function()
			require("recorder").setup({})
		end,
	},

	{
		"folke/noice.nvim",
		config = function()
			require("config.noice")
		end,
		dependencies = { "MunifTanjim/nui.nvim" },
	},

	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({})
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "RileyGabrielson/tmux-status.nvim" },
		config = function()
			require("config.lualine")
		end,
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("config.mason")
		end,
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
							{ "kind_icon", "kind", gap = 1 },
						},
					},
				},
			},
		},
	},

	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("config.conform")
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"RileyGabrielson/inspire.nvim",
		config = function()
			require("inspire").setup({})
		end,
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
	},

	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.fzf")
		end,
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "echasnovski/mini.icons", "RileyGabrielson/inspire.nvim" },
		config = function()
			require("config.alpha")
		end,
	},
}

return plugins
