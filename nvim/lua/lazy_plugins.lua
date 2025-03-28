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

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

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

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim" },
		},
		config = function()
			require("config.telescope")
		end,
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
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false,
				},
				lightbulb = {
					enable = false,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.lualine")
		end,
	},

	{
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},

	{
		"Pocco81/HighStr.nvim",
		config = function()
			require("high-str").setup({
				highlight_colors = {
					color_1 = { "#D79921", "smart" },
				},
			})
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
}

return plugins
