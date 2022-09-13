require"which-key".setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },

  window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
      padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },

  hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true -- show help message on the command line when the popup is visible
})

-- Set leader
vim.g.mapleader = ' '

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>H', ':set hlsearch!<CR>', {noremap = true, silent = true})

local normal_options = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local visual_options = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true -- use `nowait` when creating keymaps
}

-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

vim.api.nvim_set_keymap("n", "<Tab>", "<C-w><C-w>", {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", "<Leader><Tab>", "<C-^>", {noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<Leader>e", ":NERDTreeFocus<CR>", {noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<Leader>p", ":GFiles<CR>", {noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<Leader>P", ":Files<CR>", {noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<Leader>f", ":Ag<CR>", {noremap=true, silent=false})

local normal_mappings = {
  ["e"] = "Explorer",
  ["p"] = "Find File",
  ["P"] = "Find Any File",
  ["f"] = "Find Text",
  ["<Tab>"] = "Next Window",

  l = {
    name = "LSP",
    d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Definition"},
    h = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Hover"},
    r = {"<cmd>lua vim.lsp.buf.references()<CR>", "References"},
    s = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol"},
    ["."] = {"<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action"},
    i = {"<cmd>LspInfo<CR>", "Info"},
  },

  g = {
    name = "Git",
    g = {":Git", "Git Home"},
    b = {":GitBlameToggle<CR>", "Git Blame"},
  },

  T = {
    name = "Trouble",
    d = {":Trouble document_diagnostics", "Document Diagnostics"},
    w = {":Trouble workplace_diagnostics", "Workplace Diagnostics"},
  },

  r = {
    name = "Repositories",
    d = {":e ~/dot-files/README.md<CR>", "Dot Files"},
    n = {":e ~/r/neo/package.json", "Neo"},
  },

  m = {
    name = "Manipulate",
    c = {":CommentToggle<CR>", "Comment"}
  }
}

local visual_mappings = {
  m = {
    name = "Manipulate",
    c = {"<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment"}
  }
}

local wk = require("which-key")
wk.register(normal_mappings, normal_options)
wk.register(visual_mappings, visual_options)
