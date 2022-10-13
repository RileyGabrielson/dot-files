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

vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<S-Tab>", "<C-w><C-w>", {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", "<Leader><Tab>", "<C-^>", {noremap=true, silent=false})
vim.api.nvim_set_keymap('n', '<Leader>p', '<cmd>lua require("config.telescope").project_files()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope live_grep<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Leader>b', "<cmd>lua require'telescope.builtin'.git_branches{}<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Leader>z', ':ZenMode<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap("n", "<Leader>x", ":Trouble document_diagnostics<CR>", {noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<Leader>S", "<cmd>lua require('spectre').open()<CR>", {noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<Leader>y", "\"+y", {noremap=true, silent=false})

vim.api.nvim_set_keymap("t", "<S-Esc>", [[<C-\><C-n>]], {noremap=true, silent=false})

vim.api.nvim_set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", {noremap=true, silent=false})
vim.api.nvim_set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", {noremap=true, silent=false})
vim.api.nvim_set_keymap("v", "<Leader>y", "\"+y", {noremap=true, silent=false})
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap=true, silent=true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap=true, silent=true})

local use_styles_snippet = require("commands.make_styles_snippet")

local normal_mappings = {
  ["p"] = "Find File Fuzzy",
  ["f"] = "Find Text",
  ["<Tab>"] = "Next Window",
  ["z"] = "Zen Mode",
  ["x"] = "Trouble Diagnostics",
  ["S"] = "Spectre",
  ["y"] = "Yank to Clipboard",

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
    c = {":NvimTreeClose<CR>", "Close"},
    e = {":NvimTreeFocus<CR>", "Focus"},
  },

  l = {
    name = "LSP",
    d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Definition"},
    t = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition"},
    h = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Hover"},
    r = {"<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", "Find Git Files"},
    s = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol"},
    ["."] = {"<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action"},
    i = {"<cmd>LspInfo<CR>", "Info"},
    e = {"<cmd>lua require('lsp_lines').toggle()<CR>", "Toggle Errors"},
  },

  g = {
    name = "Git",
    g = {":Git<CR>", "Git Home"},
    b = {":GitBlameToggle<CR>", "Git Blame"},
    s = {"<cmd>Telescope git_status<cr>", "Git Status"},
  },

  t = {
    name = "Telescope",
    r = {"<cmd>Telescope resume<cr>", "Resume"},
    g = {"<cmd>lua require'telescope.builtin'.git_files{}<CR>", "Find Git Files"},
    s = {"<cmd>Telescope git_status<cr>", "Git Status"},
    b = {"<cmd>Telescope buffers<cr>", "Find Buffers"},
    h = {"<cmd>Telescope help_tags<cr>", "Find Help Tags"},
    c = {"<cmd>Telescope command_history<cr>", "List Commands That Were Executed"},
    q = {"<cmd>Telescope quickfix<cr>", "List Items In The Quikcfix List"},
    a = {'<cmd>lua require("telescope.builtin").find_files({ fuzzy = true })<CR>', "All files"},
    l = {
        name = "Lsp",
        r = {"<cmd>Telescope lsp_references<cr>", "References for word under cursor"},
        c = {"<cmd>Telescope lsp_code_actions<cr>", "Code Actions for word under cursor"},
        i = {"<cmd>Telescope lsp_implementations<cr>", "GoTo Implementation"},
        d = {"<cmd>Telescope lsp_definitions<cr>", "GoTo Definition"},
    },
  },

  r = {
    name = "Repositories",
    d = {":e ~/dot-files/README.md<CR>:cd ~/dot-files/<CR>", "Dot Files"},
    n = {":e ~/r/neo/package.json<CR>:cd ~/r/neo/<CR>", "Neo"},
    o = {":e ~/notes/index.norg<CR>:cd ~/notes/<CR>", "Notes"},
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
    },
    u = {use_styles_snippet, "Use Styles Snippet"}
  },

  w = {
    name = "Windows",
    v = {"<C-w><C-v>", "Vertical Split"},
    s = {"<C-w><C-s>", "Horizontal Split"},
    o = {"<C-w><C-o>", "Close All Windows Except Current"},
    c = {"<C-w><C-c>", "Close Current Window"},
  },

  m = {
    name = "Misc",
    c = {":CommentToggle<CR>", "Comment"},
    r = {":%s/\\<<C-r><C-w>\\>/", "Replace"},
    h = {":noh<CR>", "Hide Search"},
    d = {"<cmd>lua require'commands.misc_commands'.toggle_diagnostics()<CR>", "Diagnostics"},
  },

  h = {
    name = "Harpoon",
    a = {"<cmd>lua require'harpoon.mark'.add_file()<CR>", "Add File"},
    v = {"<cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>", "View Quick Menu"},
    ["1"] = {"<cmd>lua require'harpoon.ui'.nav_file(1)<CR>", "File 1"},
    ["2"] = {"<cmd>lua require'harpoon.ui'.nav_file(2)<CR>", "File 2"},
    ["3"] = {"<cmd>lua require'harpoon.ui'.nav_file(3)<CR>", "File 3"},
    ["4"] = {"<cmd>lua require'harpoon.ui'.nav_file(4)<CR>", "File 4"},
    ["5"] = {"<cmd>lua require'harpoon.ui'.nav_file(5)<CR>", "File 5"},
    ["6"] = {"<cmd>lua require'harpoon.ui'.nav_file(6)<CR>", "File 6"},
    ["7"] = {"<cmd>lua require'harpoon.ui'.nav_file(7)<CR>", "File 7"},
    ["8"] = {"<cmd>lua require'harpoon.ui'.nav_file(8)<CR>", "File 8"},
    ["9"] = {"<cmd>lua require'harpoon.ui'.nav_file(9)<CR>", "File 9"},
  },

  d = {
    b = {"<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Breakpoint"},
  },
}

local visual_mappings = {
  m = {
    name = "Manipulate",
    c = {":CommentToggle<CR>", "Comment"},
    k = {":s/\\(\\w.*\\)/", "Fighting One Eyed Kirby"},
  }
}

local wk = require("which-key")
wk.register(normal_mappings, normal_options)
wk.register(visual_mappings, visual_options)
