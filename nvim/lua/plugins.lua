vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- package manager
  use 'L3MON4D3/LuaSnip' -- fancy status bar
  use 'RRethy/vim-illuminate' -- highlight current word
  use 'f-person/git-blame.nvim' -- git blame toggling
  use 'svermeulen/vimpeccable' -- mapping keybinds to lua functions
  use 'prettier/vim-prettier' -- prettier formatting
  use 'folke/lua-dev.nvim' -- get neovim lua dev setup right
  use 'nvim-lua/plenary.nvim' -- lua function helpers, required for telescope
  use 'nvim-treesitter/playground' -- view treesitter tree
  use 'mbbill/undotree' -- visualize vim's undo tree
  use 'unblevable/quick-scope' -- highlighting f and t jumping
  use 'wellle/targets.vim'
  use 'tpope/vim-surround'
  use 'pest-parser/pest.vim' -- pest syntax highlighting
  use 'kdheepak/lazygit.nvim'
  use 'hrsh7th/cmp-nvim-lsp' -- auto complete lsp
  use 'hrsh7th/cmp-nvim-lua' -- auto complete lua
  use 'hrsh7th/cmp-path' -- auto complete system paths
  use 'jose-elias-alvarez/typescript.nvim' -- typescript lsp server config and function exposure

  -- color schemes
  use 'sainnhe/everforest'  -- green color scheme
  use 'sainnhe/gruvbox-material'
  use 'rebelot/kanagawa.nvim' -- tokyonight meets gruvbox
  use 'folke/tokyonight.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use "ellisonleao/gruvbox.nvim"


  use {
    "folke/which-key.nvim",
    config = function() require("config.which-key") end,
  }

  use {
    'j-hui/fidget.nvim', -- lsp progress
    config = function() require'fidget'.setup() end,
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
    "folke/zen-mode.nvim",
    config = function() require("zen-mode").setup { } end
  }

  use {
    "kyazdani42/nvim-tree.lua",
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
    'windwp/nvim-ts-autotag', -- auto generate typescript tags (<div>, <p>, etc)
    config = function() require'nvim-treesitter.configs'.setup{ autotag = { enable = true } } end,
  }

  use {
    'ThePrimeagen/harpoon', -- Persistent, smart marks per feature. the best thing ever.
    config = function() require("config.harpoon") end,
  }

  use {
    "windwp/nvim-autopairs", -- auto pairs
    config = function() require("nvim-autopairs").setup {} end
  }


  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require("config.diffview") end,
  }

  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    },
  }

  use {
    "folke/twilight.nvim",
    config = function() require("config.twilight") end
  }

  use {
    "chrisgrieser/nvim-recorder",
    config = function() require("recorder").setup({}) end,
  }

  use {
    "rcarriga/nvim-notify",
    config = function() require("config.notify") end,
  }

  -- LSP and Debugging

  use {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'jayp0521/mason-nvim-dap.nvim'
  }
  use {
    "mxsdev/nvim-dap-vscode-js",
    requires = {"mfussenegger/nvim-dap"},
  }
  use {
    "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap"},
  }

end)
