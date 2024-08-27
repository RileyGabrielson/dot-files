local plugins = {
  'RRethy/vim-illuminate',
  'f-person/git-blame.nvim',
  'svermeulen/vimpeccable', -- mapping keybinds to lua functions
  'prettier/vim-prettier',
  'folke/lua-dev.nvim',
  'nvim-lua/plenary.nvim', -- lua function helpers, required for telescope
  'nvim-treesitter/playground',
  'mbbill/undotree',
  'unblevable/quick-scope', -- highlighting f and t jumping
  'hrsh7th/cmp-nvim-lsp', -- auto complete lsp
  'hrsh7th/cmp-nvim-lua', -- auto complete lua
  'hrsh7th/cmp-path', -- auto complete system paths
  'jose-elias-alvarez/typescript.nvim',
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  'JoosepAlviste/nvim-ts-context-commentstring',

  "ellisonleao/gruvbox.nvim",

  {
    "folke/which-key.nvim",
    config = function() require("config.which-key") end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('config.treesitter') end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function() require('config.gitsigns') end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.lualine') end,
  },

  {
    'folke/trouble.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons'},
    config = function() require('config.trouble') end,
  },

  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  {
    'hrsh7th/nvim-cmp', -- auto complete
    config = function() require('config.cmp') end,
  },

  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
      'nvim-telescope/telescope.nvim',
      dependencies = {
          {'nvim-lua/plenary.nvim'},
          {'nvim-telescope/telescope-fzf-native.nvim'},
      },
      config = function() require("config.telescope") end
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("oil").setup({
      view_options = {
        show_hidden = true,
        skip_confirm_for_simple_edits = true
      }
    }) end,
  },

  {
    "terrortylor/nvim-comment",
    config = function() require("config.comment") end
  },


  {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  },

  {
    'ThePrimeagen/harpoon',
    config = function() require("config.harpoon") end,
  },

  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },

  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require("config.diffview") end,
  },

  {
    "chrisgrieser/nvim-recorder",
    config = function() require("recorder").setup({}) end,
  },

  {
    "rcarriga/nvim-notify",
    config = function() require("config.notify") end,
  },

  {
    'folke/noice.nvim',
    config = function() require("config.noice") end,
    dependencies = { 'MunifTanjim/nui.nvim', },
  },

  {
    "smjonas/inc-rename.nvim",
    config = function() require("inc_rename").setup() end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },

  {
    'nvimdev/lspsaga.nvim',
    config = function() require('lspsaga').setup({
      symbol_in_winbar = {
        enable = false
      },
      lightbulb = {
        enable = false,
      }
    }) end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    }
  }
}

return plugins
