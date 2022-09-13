vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- package manager
  use 'neovim/nvim-lspconfig' -- configurations for nvim LSP
  use 'joshdick/onedark.vim' -- onedark color scheme
  use 'lunarvim/colorschemes' -- additional color scheme options
  use 'preservim/nerdtree' -- file explorer
  use 'xuyuanp/nerdtree-git-plugin' -- git indicators for file explorer
  use 'easymotion/vim-easymotion' -- easy motion movement
  use 'junegunn/fzf' -- fuzzy finder
  use 'junegunn/fzf.vim' -- fuzzy finder vim implementation
  use 'L3MON4D3/LuaSnip' -- fancy status bar
  use 'RRethy/vim-illuminate' -- highlight current word
  use 'f-person/git-blame.nvim' -- git blame toggling
  use 'kyazdani42/nvim-web-devicons' -- icon pack
  use 'svermeulen/vimpeccable' -- mapping keybinds to lua functions
  use 'tpope/vim-fugitive' -- git solution
  use 'prettier/vim-prettier' -- prettier formatting
  use 'folke/lua-dev.nvim' -- get neovim lua dev setup right

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
    'terrortylor/nvim-comment', -- comment selections
    config = function() require('config.comment') end,
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
    event = "BufReadPre",
    config = function() require('config.dressing') end,
    disable = false,
}

  use {
    'hrsh7th/nvim-cmp', -- auto complete
    config = function() require('config.cmp') end,
  }
  use 'hrsh7th/cmp-nvim-lsp' -- auto complete lsp
  use 'hrsh7th/cmp-nvim-lua' -- auto complete lua
  use 'hrsh7th/cmp-path' -- auto complete system paths

end)

