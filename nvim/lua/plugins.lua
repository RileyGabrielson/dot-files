vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- package manager
  use 'neovim/nvim-lspconfig' -- configurations for nvim LSP
  use 'L3MON4D3/LuaSnip' -- fancy status bar
  use 'RRethy/vim-illuminate' -- highlight current word
  use 'f-person/git-blame.nvim' -- git blame toggling
  use 'svermeulen/vimpeccable' -- mapping keybinds to lua functions
  use 'tpope/vim-fugitive' -- git solution
  use 'prettier/vim-prettier' -- prettier formatting
  use 'folke/lua-dev.nvim' -- get neovim lua dev setup right
  use 'nvim-lua/plenary.nvim' -- lua function helpers, required for telescope
  use 'kyazdani42/nvim-web-devicons' -- optional, for file icons
  use 'nvim-treesitter/playground' -- view treesitter tree
  use 'ThePrimeagen/harpoon' -- Persistent, smart marks per feature
  -- color schems
  use 'joshdick/onedark.vim' -- onedark color scheme
  use 'lunarvim/colorschemes' -- bunch of lunar color scheme options
  use 'sainnhe/everforest'  -- green color scheme
  use 'folke/tokyonight.nvim' -- dark purple color scheme
  use 'ellisonleao/gruvbox.nvim' -- popular gruvbox color scheme
  use 'mbbill/undotree' -- visualize vim's undo tree

  use {
    "folke/which-key.nvim",
    config = function() require("config.which-key") end,
  }

  use {
    'j-hui/fidget.nvim', -- lsp progress
    config = function() require'fidget'.setup() end,
  }

  use {
    'akinsho/toggleterm.nvim', -- popup terminal
    config = function() require('config.toggleterm') end,
  }
  use {
    'nvim-treesitter/nvim-treesitter', -- better syntax recognition
    config = function() require('config.treesitter') end,
  }

  use {
    'ray-x/lsp_signature.nvim', -- auto completion signature window
    config = function() require('config.signature') end,
  }

  use {
    'lewis6991/gitsigns.nvim', -- git changes in editor
    config = function() require('config.gitsigns') end,
  }

  use {
    'nvim-lualine/lualine.nvim', -- fancy status bar
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.lualine') end,
  }

  use {
    'folke/trouble.nvim', -- issues popup window
    requires = { 'kyazdani42/nvim-web-devicons'},
    config = function() require('config.trouble') end,
  }

  use {
    "stevearc/dressing.nvim", -- fancy up ui windows
    config = function() require('config.dressing') end,
}

  use {
    'hrsh7th/nvim-cmp', -- auto complete
    config = function() require('config.cmp') end,
  }
  use 'hrsh7th/cmp-nvim-lsp' -- auto complete lsp
  use 'hrsh7th/cmp-nvim-lua' -- auto complete lua
  use 'hrsh7th/cmp-path' -- auto complete system paths

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
      'nvim-telescope/telescope.nvim', -- telescope fuzzy finder
      requires = {
          {'nvim-lua/plenary.nvim'},
          {'nvim-telescope/telescope-fzf-native.nvim'},
      },
      config = function() require("config.telescope") end
  }

  use {
    "nvim-pack/nvim-spectre",
    config = function() require("config.spectre") end
  }

  use {
    "folke/zen-mode.nvim",
    config = function() require("zen-mode").setup { } end
  }

  use {
      "nvim-neorg/neorg",
      tag = '0.0.12',
      after = "nvim-treesitter",
      requires = "nvim-lua/plenary.nvim",
      config = function() require("config.neorg") end,
  }

  use {
    "kyazdani42/nvim-tree.lua",
    requires = { 'kyazdani42/nvim-web-devicons' },
    tag = 'nightly',
    config = function() require("config.nvim-tree") end,
  }

  use {
    "terrortylor/nvim-comment",
    config = function() require("config.comment") end
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
          space_char_blankline = " ",
          show_current_context = true,
          show_current_context_start = true,
      }
    end
  }

  use {
    'norcalli/nvim-colorizer.lua', -- shows colors as background to color strings
    config = function() require('colorizer').setup() end,
  }

  use {
    'akinsho/bufferline.nvim', -- Fancier buffer line
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use {
    'windwp/nvim-ts-autotag',
    config = function() require'nvim-treesitter.configs'.setup{ autotag = { enable = true } } end,
  }


end)

