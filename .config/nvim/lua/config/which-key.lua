local which_key = require("which-key")

which_key.setup({
	preset = "modern",
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

	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},

	show_help = true,
})

-- Set leader
vim.g.mapleader = " "

local use_styles_snippet = require("commands.make_styles_snippet")

which_key.add({
	{
		mode = { "n" },
		{
			"<leader>%",
			'<cmd>lua require("commands.get_filename").copy_file_path()<CR>',
			desc = "Get Filename to Clipboard",
			nowait = false,
			remap = false,
		},
		{ "<leader><Enter>", "<C-6>", desc = "Alternate File", nowait = false, remap = false },
		{ "<leader>S", "<cmd>lua require'commands.templates'()<CR>", desc = "Snippets", nowait = false, remap = false },
		{ "<leader>b", group = "Buffers", nowait = false, remap = false },
		{ "<leader>bl", "<cmd>ls<CR>", desc = "List buffers", nowait = false, remap = false },
		{ "<leader>bx", "<cmd>%bd|e#|bd#<CR>", desc = "Close all other buffers", nowait = false, remap = false },
		{ "<leader>c", group = "Quick Fix", nowait = false, remap = false },
		{ "<leader>cc", "<cmd>cclose<CR>", desc = "Close Quickfix", nowait = false, remap = false },
		{ "<leader>cd", ":cdo ", desc = "Do", nowait = false, remap = false },
		{ "<leader>cn", "<cmd>cnext<CR>", desc = "Next Item", nowait = false, remap = false },
		{ "<leader>co", "<cmd>copen<CR>", desc = "Open Quickfix", nowait = false, remap = false },
		{ "<leader>cp", "<cmd>cprev<CR>", desc = "Previous Item", nowait = false, remap = false },
		{ "<leader>cr", ":cdo s/", desc = "Replace", nowait = false, remap = false },
		{ "<leader>cx", "<cmd>call setqflist([])<CR>", desc = "Clear List", nowait = false, remap = false },
		{ "<leader>d", group = "Debugging", nowait = false, remap = false },
		{
			"<leader>dB",
			"<cmd>lua require'dap'.clear_breakpoints()<CR>",
			desc = "Remove All Breakpoints",
			nowait = false,
			remap = false,
		},
		{
			"<leader>db",
			"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
			desc = "Breakpoint Toggle",
			nowait = false,
			remap = false,
		},
		{ "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", desc = "Continue", nowait = false, remap = false },
		{
			"<leader>dh",
			":lua require'dapui'.eval()<CR>:lua require'dapui'.eval()<CR>",
			desc = "Hover Info",
			nowait = false,
			remap = false,
		},
		{ "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into", nowait = false, remap = false },
		{ "<leader>do", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step Out", nowait = false, remap = false },
		{ "<leader>dq", "<cmd>lua require'dapui'.close()<CR>", desc = "Quit UI", nowait = false, remap = false },
		{ "<leader>ds", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over", nowait = false, remap = false },
		{ "<leader>dt", "<cmd>lua require'dap'.terminate()<CR>", desc = "Terminate", nowait = false, remap = false },
		{ "<leader>e", group = "Explorer", nowait = false, remap = false },
		{
			"<leader>ef",
			"<cmd>lua require'oil'.open(require'oil'.get_current_dir())<CR>",
			desc = "Find",
			nowait = false,
			remap = false,
		},
		{ "<leader>f", "<cmd>lua require'fzf-lua'.live_grep()<CR>", desc = "Find Text", nowait = false, remap = false },
		{ "<leader>g", group = "Git", nowait = false, remap = false },
		{ "<leader>gb", ":GitBlameToggle<CR>", desc = "Git Blame", nowait = false, remap = false },
		{ "<leader>gl", ":LazyGit<CR>", desc = "Lazy Git", nowait = false, remap = false },
		{ "<leader>h", group = "Harpoon", nowait = false, remap = false },
		{
			"<leader>h1",
			"<cmd>lua require'harpoon.ui'.nav_file(1)<CR>",
			desc = "File 1",
			nowait = false,
			remap = false,
		},
		{
			"<leader>h2",
			"<cmd>lua require'harpoon.ui'.nav_file(2)<CR>",
			desc = "File 2",
			nowait = false,
			remap = false,
		},
		{
			"<leader>h3",
			"<cmd>lua require'harpoon.ui'.nav_file(3)<CR>",
			desc = "File 3",
			nowait = false,
			remap = false,
		},
		{
			"<leader>h4",
			"<cmd>lua require'harpoon.ui'.nav_file(4)<CR>",
			desc = "File 4",
			nowait = false,
			remap = false,
		},
		{
			"<leader>h5",
			"<cmd>lua require'harpoon.ui'.nav_file(5)<CR>",
			desc = "File 5",
			nowait = false,
			remap = false,
		},
		{
			"<leader>h6",
			"<cmd>lua require'harpoon.ui'.nav_file(6)<CR>",
			desc = "File 6",
			nowait = false,
			remap = false,
		},
		{
			"<leader>h7",
			"<cmd>lua require'harpoon.ui'.nav_file(7)<CR>",
			desc = "File 7",
			nowait = false,
			remap = false,
		},
		{
			"<leader>h8",
			"<cmd>lua require'harpoon.ui'.nav_file(8)<CR>",
			desc = "File 8",
			nowait = false,
			remap = false,
		},
		{
			"<leader>h9",
			"<cmd>lua require'harpoon.ui'.nav_file(9)<CR>",
			desc = "File 9",
			nowait = false,
			remap = false,
		},
		{
			"<leader>ha",
			"<cmd>lua require'harpoon.mark'.add_file()<CR>",
			desc = "Add File",
			nowait = false,
			remap = false,
		},
		{
			"<leader>hv",
			"<cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>",
			desc = "View Quick Menu",
			nowait = false,
			remap = false,
		},
		{ "<leader>i", desc = "Cheat Sheet", nowait = false, remap = false },
		{ "<leader>l", group = "LSP", nowait = false, remap = false },
		{ "<leader>l.", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action", nowait = false, remap = false },
		{ "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition", nowait = false, remap = false },
		{ "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format", nowait = false, remap = false },
		{ "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover", nowait = false, remap = false },
		{
			"<leader>li",
			"<cmd>lua vim.lsp.buf.implementation()<CR>",
			desc = "Implementations",
			nowait = false,
			remap = false,
		},
		{
			"<leader>lr",
			"<cmd>lua require'fzf-lua'.lsp_references()<CR>",
			desc = "Find Git Files",
			nowait = false,
			remap = false,
		},
		{ "<leader>ls", ":IncRename ", desc = "Rename Symbol", nowait = false, remap = false },
		{
			"<leader>lt",
			"<cmd>lua vim.lsp.buf.type_definition()<CR>",
			desc = "Type Definition",
			nowait = false,
			remap = false,
		},
		{ "<leader>lc", "<cmd>checkhealth vim.lsp<CR>", desc = "Check Health", nowait = false, remap = false },
		{ "<leader>m", group = "Misc", nowait = false, remap = false },
		{
			"<leader>mb",
			"<cmd>lua require'commands.toggle_background'()<CR>",
			desc = "Toggle Background",
			nowait = false,
			remap = false,
		},
		{ "<leader>mc", ":CommentToggle<CR>", desc = "Comment", nowait = false, remap = false },
		{
			"<leader>md",
			"<cmd>lua require'commands.misc_commands'.toggle_diagnostics()<CR>",
			desc = "Diagnostics",
			nowait = false,
			remap = false,
		},
		{
			"<leader>mf",
			"<cmd>lua require'config.conform'.toggle_auto_formatting()<CR>",
			desc = "Toggle Auto Formatting",
			nowait = false,
			remap = false,
		},
		{ "<leader>mh", ":noh<CR>", desc = "Hide Search", nowait = false, remap = false },
		{ "<leader>mr", ":%s/\\<<C-r><C-w>\\>/", desc = "Replace", nowait = false, remap = false },
		{
			"<leader>mv",
			"<cmd>lua require'commands.get_verse'()<CR>",
			desc = "Get Scripture Verse",
			nowait = false,
			remap = false,
		},
		{
			"<leader>p",
			desc = "Find File Fuzzy",
			"<cmd>lua require('fzf-lua').files()<CR>",
			nowait = false,
			remap = false,
		},
		{ "<leader>s", desc = "Tmux Session", nowait = false, remap = false },
		{ "<leader>t", group = "Fzf Lua", nowait = false, remap = false },
		{
			"<leader>tc",
			"<cmd>lua require('fzf-lua').command_history()<cr>",
			desc = "List Commands That Were Executed",
			nowait = false,
			remap = false,
		},
		{
			"<leader>tg",
			"<cmd>lua require'fzf-lua'.git_files()<CR>",
			desc = "Find Git Files",
			nowait = false,
			remap = false,
		},
		{
			"<leader>th",
			"<cmd>lua require'fzf-lua'.helptags()<cr>",
			desc = "Find Help Tags",
			nowait = false,
			remap = false,
		},
		{ "<leader>tr", "<cmd>lua require'fzf-lua'.resume()<cr>", desc = "Resume", nowait = false, remap = false },
		{ "<leader>u", group = "Utility", nowait = false, remap = false },
		{ "<leader>us", use_styles_snippet, desc = "Use Styles Snippet", nowait = false, remap = false },
		{
			"<leader>ut",
			"<cmd>lua require'commands.test_coverage'()<CR>",
			desc = "Test Coverage",
			nowait = false,
			remap = false,
		},
		{ "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree", nowait = false, remap = false },
		{ "<leader>v", group = "Diff View", nowait = false, remap = false },
		{ "<leader>vc", "<cmd>DiffviewClose<CR>", desc = "Close DiffView", nowait = false, remap = false },
		{ "<leader>vf", "<cmd>DiffviewFileHistory %<CR>", desc = "File History", nowait = false, remap = false },
		{
			"<leader>vm",
			"<cmd>DiffviewOpen origin/master...HEAD<CR>",
			desc = "Master DiffView",
			nowait = false,
			remap = false,
		},
		{ "<leader>vo", "<cmd>DiffviewOpen<CR>", desc = "Open DiffView", nowait = false, remap = false },
		{ "<leader>w", group = "Windows", nowait = false, remap = false },
		{
			"<leader>w+",
			'<cmd>exe "resize " . (winheight(0) * 5/4)<CR>',
			desc = "Increase height",
			nowait = false,
			remap = false,
		},
		{
			"<leader>w-",
			'<cmd>exe "resize " . (winheight(0) * 4/5)<CR>',
			desc = "Decrease height",
			nowait = false,
			remap = false,
		},
		{
			"<leader>w<",
			'<cmd>exe "vertical resize " . (winwidth(0) * 4/5)<cr>',
			desc = "increase width",
			nowait = false,
			remap = false,
		},
		{ "<leader>w=", "<c-w>=", desc = "equalize windows", nowait = false, remap = false },
		{
			"<leader>w>",
			'<cmd>exe "vertical resize " . (winwidth(0) * 5/4)<CR>',
			desc = "Increase width",
			nowait = false,
			remap = false,
		},
		{ "<leader>wS", "<C-w>t<C-w>K", desc = "Vertical Split to Horizontal", nowait = false, remap = false },
		{ "<leader>wV", "<C-w>t<C-w>H", desc = "Horizontal Split to Vertical", nowait = false, remap = false },
		{
			"<leader>w_",
			'<cmd>exe "resize " . (winheight(0) * 4/5)<CR>',
			desc = "Decrease height",
			nowait = false,
			remap = false,
		},
		{ "<leader>wc", "<C-w><C-c>", desc = "Close Current Window", nowait = false, remap = false },
		{ "<leader>wh", "<C-w><C-h>", desc = "Left Window", nowait = false, remap = false },
		{ "<leader>wj", "<C-w><C-j>", desc = "Bottom Window", nowait = false, remap = false },
		{ "<leader>wk", "<C-w><C-k>", desc = "Top Window", nowait = false, remap = false },
		{ "<leader>wl", "<C-w><C-l>", desc = "Right Window", nowait = false, remap = false },
		{ "<leader>wo", "<C-w><C-o>", desc = "Close All Windows Except Current", nowait = false, remap = false },
		{ "<leader>wq", "<C-w><C-c>", desc = "Close Current Window", nowait = false, remap = false },
		{ "<leader>ws", "<C-w><C-s>", desc = "Horizontal Split", nowait = false, remap = false },
		{ "<leader>wv", "<C-w><C-v>", desc = "Vertical Split", nowait = false, remap = false },
		{
			"<leader>x",
			":Trouble diagnostics toggle focus=true filter.buf=0<CR>",
			desc = "Trouble Diagnostics",
			nowait = false,
			remap = false,
		},
		{ "<leader>y", '"+y', desc = "Yank to Clipboard", nowait = false, remap = false },

		{ "H", "^", desc = "Beginning of line", { noremap = true, silent = true } },
		{ "L", "$", desc = "End of line", { noremap = true, silent = true } },
		{ "<C-u>", "<C-u>zz", desc = "Center on up", { silent = true } },
		{ "<C-d>", "<C-d>zz", desc = "Center on down", { silent = true } },
	},
})

which_key.add({
	{
		mode = { "v" },
		{ "<", "<gv", { noremap = true, silent = true } },
		{ ">", ">gv", { noremap = true, silent = true } },
		{ "<leader>m", group = "Manipulate", nowait = true, remap = false },
		{ "<leader>mc", ":CommentToggle<CR>", desc = "Comment", nowait = true, remap = false },
		{ "<leader>y", '"+y', desc = "Yank to Clipboard", nowait = false, remap = false },
	},
})
