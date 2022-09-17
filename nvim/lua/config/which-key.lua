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

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>H', ':set hlsearch!<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Tab>", "<C-w><C-w>", {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", "<Leader><Tab>", "<C-^>", {noremap=true, silent=false})

vim.api.nvim_set_keymap('n', '<Leader>p', '<cmd>lua require("config.telescope").project_files()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>P', '<cmd>lua require("telescope.builtin").find_files({ fuzzy = false })<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope live_grep<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Leader>z', ':ZenMode<CR>', {noremap = true, silent = false})

vim.api.nvim_set_keymap("t", "<S-Esc>", [[<C-\><C-n>]], {noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<Leader>x", ":Trouble document_diagnostics<CR>", {noremap=true, silent=false})

local normal_mappings = {
  ["p"] = "Find File Fuzzy",
  ["P"] = "Find File Exact",
  ["f"] = "Find Text",
  ["<Tab>"] = "Next Window",
  ["z"] = "Zen Mode",
  ["x"] = "Trouble Diagnostics",

  u = {
    name = "Terminal",
    ["1"] = {":1ToggleTerm<CR>", "Terminal 1"},
    ["2"] = {":2ToggleTerm<CR>", "Terminal 2"},
    ["3"] = {":3ToggleTerm<CR>", "Terminal 3"},
    ["4"] = {":4ToggleTerm<CR>", "Terminal 4"},
    ["5"] = {":5ToggleTerm<CR>", "Terminal 5"},
  },

  e = {
    name = "Explorer",
    f = {":NvimTreeFindFile<CR>", "Find"},
    c = {":NvimTreeCollapse<CR>", "Close"},
    e = {":NvimTreeFocus<CR>", "Focus"},
  },

  l = {
    name = "LSP",
    d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Definition"},
    t = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition"},
    h = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Hover"},
    r = {"<cmd>lua vim.lsp.buf.references()<CR>", "References"},
    s = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol"},
    ["."] = {"<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action"},
    i = {"<cmd>LspInfo<CR>", "Info"},
    e = {"<cmd>lua require('lsp_lines').toggle()<CR>", "Toggle Errors"},
  },

  g = {
    name = "Git",
    g = {":Git<CR>", "Git Home"},
    b = {":GitBlameToggle<CR>", "Git Blame"},
  },

  t = {
    name = "Telescope",
    r = {"<cmd>Telescope resume<cr>", "Resume"},
    f = {
        name = "Find",
        g = {"<cmd>lua require'telescope.builtin'.git_files{}<CR>", "Find Git Files"},
        s = {"<cmd>Telescope grep_string<cr>", "Find String Under Cursor"},
        b = {"<cmd>Telescope buffers<cr>", "Find Buffers"},
        h = {"<cmd>Telescope help_tags<cr>", "Find Help Tags"},
        c = {"<cmd>Telescope command_history<cr>", "List Commands That Were Executed"},
        q = {"<cmd>Telescope quickfix<cr>", "List Items In The Quikcfix List"},
        a = {'<cmd>lua require("telescope.builtin").find_files({ fuzzy = true })<CR>', "All files"},
    },
    l = {
        name = "Lsp",
        r = {"<cmd>Telescope lsp_references<cr>", "References for word under cursor"},
        c = {"<cmd>Telescope lsp_code_actions<cr>", "Code Actions for word under cursor"},
        i = {"<cmd>Telescope lsp_implementations<cr>", "GoTo Implementation"},
        d = {"<cmd>Telescope lsp_definitions<cr>", "GoTo Definition"},
    },
  },

  S = {
    name = "Spectre",
    S = {"<cmd>lua require('spectre').open()<CR>", "Open"},
  },

  r = {
    name = "Repositories",
    d = {":e ~/dot-files/README.md<CR>:cd ~/dot-files/<CR>", "Dot Files"},
    n = {":e ~/r/neo/package.json<CR>:cd ~/r/neo/<CR>", "Neo"},
    t = {":Neorg workspace notes<CR>", "Notes"},
    p = {":Neorg workspace notes<CR>", "Notes"},
  },

  n = {
    name = "Neo",
    t = {
      name = "Test Neo",
      o = {"<cmd>lua require'commands.test_neo'.cover_operator()<CR>", "Cover Operator"},
      c = {"<cmd>lua require'commands.test_neo'.cover_commons()<CR>", "Cover Commons"},
    },
    s = {
      name = "Start Neo",
      o = {"<cmd>lua require'commands.start_neo'.start_operator()<CR>", "Start Operator"},
      c = {"<cmd>lua require'commands.start_neo'.start_commons_cosmos()<CR>", "Start Commons Cosmos"},
      O = {"<cmd>lua require'commands.start_neo'.start_operator_cosmos()<CR>", "Start Operator Cosmos"},
    }
  },

  m = {
    name = "Manipulate",
    c = {":CommentToggle<CR>", "Comment"},
  }
}

local visual_mappings = {
  m = {
    name = "Manipulate",
    c = {":CommentToggle<CR>", "Comment"},
  }
}

local wk = require("which-key")
wk.register(normal_mappings, normal_options)
wk.register(visual_mappings, visual_options)
