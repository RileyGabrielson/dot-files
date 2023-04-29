local which_key = require("which-key")

which_key.setup({
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
vim.api.nvim_set_keymap("n", "<Leader><Tab>", "<C-^>", {noremap=true, silent=false})
vim.api.nvim_set_keymap('n', '<Leader>p', '<cmd>lua require("config.telescope").project_files()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope live_grep<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Leader>z', ':ZenMode<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap("n", "<Leader>x", ":Trouble document_diagnostics<CR>", {noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<Leader>y", "\"+y", {noremap=true, silent=false})
vim.api.nvim_set_keymap('n', '<Leader>%', '<cmd>lua require("commands.get_filename").copy_file_path()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>u', '<cmd>UndotreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>s', "<cmd>lua require'commands.templates'()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>T', "<cmd>TSC<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Leader>Y', "<cmd>lua require'commands.execute_yarn_script'()<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<Leader>r', "<cmd>lua require'commands.edit_repo'()<CR>", {noremap = true, silent = false})

vim.api.nvim_set_keymap("t", "<S-Esc>", [[<C-\><C-n>]], {noremap=true, silent=false})

vim.api.nvim_set_keymap("v", "<Leader>y", "\"+y", {noremap=true, silent=false})
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap=true, silent=true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap=true, silent=true})

vim.keymap.set({"n", "i", "s"}, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true })

vim.keymap.set({"n", "i", "s"}, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true })

local use_styles_snippet = require("commands.make_styles_snippet")

local normal_mappings = {
  ["p"] = "Find File Fuzzy",
  ["f"] = "Find Text",
  ["z"] = "Zen Mode",
  ["x"] = "Trouble Diagnostics",
  ["y"] = "Yank to Clipboard",
  ["%"] = "Get Filename to Clipboard",
  ["s"] = "Snippets",
  ["T"] = "TSC",
  ["<Tab>"] = "Alternate File",
  ["Y"] = "Yarn Command",
  ["r"] = "Repositories",

  u = {
    name = "Utility",
    t = {"<cmd>lua require'commands.jest_coverage'()<CR>", "Test Coverage"}
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
    r = {"<cmd>lua require'telescope.builtin'.lsp_references{ show_line=false }<CR>", "Find Git Files"},
    s = {":IncRename ", "Rename Symbol"},
    ["."] = {"<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action"},
    i = {"<cmd>lua vim.lsp.buf.implementation()<CR>", "Hover"},
    e = {"<cmd>lua require('lsp_lines').toggle()<CR>", "Toggle Errors"},
    f = {"<cmd>TypescriptRenameFile<CR>", "Typescript Rename File"},
  },

  g = {
    name = "Git",
    b = {":GitBlameToggle<CR>", "Git Blame"},
    s = {"<cmd>Telescope git_status<cr>", "Git Status"},
    l = {":LazyGit<CR>", "Lazy Git"},
  },

  t = {
    name = "Telescope",
    p = {'<cmd>lua require("commands.specific_telescope").find_files_within_directories()<CR>', "Find Files In Directories"},
    f = {'<cmd>lua require("commands.specific_telescope").grep_files_within_directories()<CR>', "Grep Files in Directories"},
    r = {"<cmd>Telescope resume<cr>", "Resume"},
    g = {"<cmd>lua require'telescope.builtin'.git_files{}<CR>", "Find Git Files"},
    b = {"<cmd>lua require'telescope.builtin'.git_branches()<CR>", "Git Branches"},
    h = {"<cmd>Telescope help_tags<cr>", "Find Help Tags"},
    c = {"<cmd>Telescope command_history<cr>", "List Commands That Were Executed"},
    q = {"<cmd>Telescope quickfix<cr>", "List Items In The Quickfix List"},
    a = {'<cmd>lua require("telescope.builtin").find_files({ fuzzy = true })<CR>', "All files"},
    n = {'<cmd>lua require("telescope").extensions.notify.notify()<CR>', "Notifications"},
    l = {
        name = "Lsp",
        r = {"<cmd>Telescope lsp_references<cr>", "References for word under cursor"},
        c = {"<cmd>Telescope lsp_code_actions<cr>", "Code Actions for word under cursor"},
        i = {"<cmd>Telescope lsp_implementations<cr>", "GoTo Implementation"},
        d = {"<cmd>Telescope lsp_definitions<cr>", "GoTo Definition"},
    },
  },

  n = {
    name = "Neo",
    u = {use_styles_snippet, "Use Styles Snippet"},
    t = {"<cmd>lua require'commands.test_neo'.cover_neo()<CR>", "Test Neo Coverage"},
  },

  w = {
    name = "Windows",
    h = {"<C-w><C-h>", "Left Window"},
    l = {"<C-w><C-l>", "Right Window"},
    j = {"<C-w><C-j>", "Bottom Window"},
    k = {"<C-w><C-k>", "Top Window"},
    v = {"<C-w><C-v>", "Vertical Split"},
    s = {"<C-w><C-s>", "Horizontal Split"},
    o = {"<C-w><C-o>", "Close All Windows Except Current"},
    c = {"<C-w><C-c>", "Close Current Window"},
    q = {"<C-w><C-q>", "Close Current Window"},
    V = {"<C-w>t<C-w>H", "Horizontal Split to Vertical"},
    S = {"<C-w>t<C-w>K", "Vertical Split to Horizontal"},
    ["="] = {"<C-w>=", "Equalize windows"},
    ["+"] = {'<cmd>exe "resize " . (winheight(0) * 3/2)<CR>', "Equalize windows"},
    ["-"] = {'<cmd>exe "resize " . (winheight(0) * 2/3)<CR>', "Equalize windows"},
  },

  m = {
    name = "Misc",
    c = {":CommentToggle<CR>", "Comment"},
    r = {":%s/\\<<C-r><C-w>\\>/", "Replace"},
    h = {":noh<CR>", "Hide Search"},
    d = {"<cmd>lua require'commands.misc_commands'.toggle_diagnostics()<CR>", "Diagnostics"},
    v = {"<cmd>lua require'commands.get_verse'()<CR>", "Get Scripture Verse"},
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
    name = "Debugging",
    b = {"<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Breakpoint Toggle"},
    B = {"<cmd>lua require'dap'.clear_breakpoints()<CR>", "Remove All Breakpoints"},
    c = {"<cmd>lua require'dap'.continue()<CR>", "Continue"},
    t = {"<cmd>lua require'dap'.terminate()<CR>", "Terminate"},
    s = {"<cmd>lua require'dap'.step_over()<CR>", "Step Over"},
    o = {"<cmd>lua require'dap'.step_out()<CR>", "Step Out"},
    i = {"<cmd>lua require'dap'.step_into()<CR>", "Step Into"},

    h = {":lua require'dapui'.eval()<CR>:lua require'dapui'.eval()<CR>", "Hover Info"},
    q = {"<cmd>lua require'dapui'.close()<CR>", "Quit UI"},
  },

  v = {
    name = "Diff View",
    o = {"<cmd>DiffviewOpen<CR>", "Open DiffView"},
    m = {"<cmd>DiffviewOpen origin/master...HEAD<CR>", "Master DiffView"},
    c = {"<cmd>DiffviewClose<CR>", "Close DiffView"},
  },

  c = {
    name = "Quick Fix",
    o = {"<cmd>copen<CR>", "Open Quickfix"},
    c = {"<cmd>cclose<CR>", "Close Quickfix"},
    n = {"<cmd>cnext<CR>", "Next Item"},
    p = {"<cmd>cprev<CR>", "Previous Item"},
    x = {"<cmd>call setqflist([])<CR>", "Clear List"},
    d = {":cdo ", "Do"},
    r = {":cdo s/", "Replace"},
  },

  b = {
    name = "Buffers",
    x = {"<cmd>%bd|e#|bd#<CR>", "Close all other buffers"},
    l = {"<cmd>ls<CR>", "List buffers"}
  }
}

local visual_mappings = {
  m = {
    name = "Manipulate",
    c = {":CommentToggle<CR>", "Comment"},
    k = {":s/\\(\\w.*\\)/", "Fighting One Eyed Kirby"},
  },
  r = {
    name = "Refactoring",
    f = {"<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>", "Extract Function"},
    v = {"<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable"},
  },
}

which_key.register(normal_mappings, normal_options)
which_key.register(visual_mappings, visual_options)
