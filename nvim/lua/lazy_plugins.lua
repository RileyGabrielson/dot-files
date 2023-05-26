local plugins = {
  'L3MON4D3/LuaSnip', -- fancy status bar
  'RRethy/vim-illuminate', -- highlight current word
  'f-person/git-blame.nvim', -- git blame toggling
  'svermeulen/vimpeccable', -- mapping keybinds to lua functions
  'prettier/vim-prettier', -- prettier formatting
  'folke/lua-dev.nvim', -- get neovim lua dev setup right
  'nvim-lua/plenary.nvim', -- lua function helpers, required for telescope
  'nvim-treesitter/playground', -- view treesitter tree
  'mbbill/undotree', -- visualize vim',s undo tree
  'unblevable/quick-scope', -- highlighting f and t jumping
  'wellle/targets.vim',
  'tpope/vim-surround',
  'pest-parser/pest.vim', -- pest syntax highlighting
  'kdheepak/lazygit.nvim',
  'hrsh7th/cmp-nvim-lsp', -- auto complete lsp
  'hrsh7th/cmp-nvim-lua', -- auto complete lua
  'hrsh7th/cmp-path', -- auto complete system paths
  'jose-elias-alvarez/typescript.nvim', -- typescript lsp server config and function exposure

  -- color schemes
  'sainnhe/everforest',  -- green color scheme
  'sainnhe/gruvbox-material',
  'rebelot/kanagawa.nvim', -- tokyonight meets gruvbox
  'folke/tokyonight.nvim',
  "ellisonleao/gruvbox.nvim",

  {
    "rileygabrielson/accidental-scheme.nvim",
    config = function() require("config.accidental-scheme") end
  },

  {
    "folke/which-key.nvim",
    config = function() require("config.which-key") end,
  },

  {
    'nvim-treesitter/nvim-treesitter', -- better syntax recognition
    config = function() require('config.treesitter') end,
  },

  {
    'lewis6991/gitsigns.nvim', -- git changes in editor
    config = function() require('config.gitsigns') end,
  },

  {
    'nvim-lualine/lualine.nvim', -- fancy status bar
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.lualine') end,
  },

  {
    'folke/trouble.nvim', -- issues popup window
    dependencies = { 'kyazdani42/nvim-web-devicons'},
    config = function() require('config.trouble') end,
  },

  {
    "stevearc/dressing.nvim", -- fancy up ui windows
    config = function() require('config.dressing') end,
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
    "folke/zen-mode.nvim",
    config = function() require("zen-mode").setup { } end
  },

  {
    "kyazdani42/nvim-tree.lua",
    tag = 'nightly',
    config = function() require("config.nvim-tree") end,
  },

  {
    "terrortylor/nvim-comment",
    config = function() require("config.comment") end
  },

  'JoosepAlviste/nvim-ts-context-commentstring',

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
          space_char_blankline = " ",
          show_current_context = true,
          show_current_context_start = true,
      }
    end
  },

  {
    'norcalli/nvim-colorizer.lua', -- shows colors as background to color strings
    config = function() require('colorizer').setup() end,
  },

  {
    'windwp/nvim-ts-autotag', -- auto generate typescript tags (<div>, <p>, etc)
    config = function() require'nvim-treesitter.configs'.setup{ autotag = { enable = true } } end,
  },

  {
    'ThePrimeagen/harpoon', -- Persistent, smart marks per feature. the best thing ever.
    config = function() require("config.harpoon") end,
  },

  {
    "windwp/nvim-autopairs", -- auto pairs
    config = function() require("nvim-autopairs").setup {} end
  },

  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require("config.diffview") end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    },
  },

  {
    "chrisgrieser/nvim-recorder",
    config = function() require("recorder").setup({}) end,
  },

  {
    "rcarriga/nvim-notify",
    config = function() require("config.notify") end,
  },

  -- LSP and Debugging

  {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-nvim-dap.nvim"
  },

  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {"mfussenegger/nvim-dap"},
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap"},
  },

  {
    'kevinhwang91/nvim-bqf',
    config = function() require("config.quickfix") end,
  }, -- quick fix improvements

  {
    'dmmulroy/tsc.nvim',
    config = function() require('tsc').setup() end,
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
    'glacambre/firenvim',
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
        require("lazy").load({ plugins = "firenvim", wait = true })
        vim.fn["firenvim#install"](0)
    end
  },

  {
    'github/copilot.vim',
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end, 
    ft = { "markdown" },
  }
-- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

}

return plugins
