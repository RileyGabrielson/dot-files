vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.magic = true
vim.opt.showmatch = true
vim.opt.belloff = "all"
vim.opt.foldcolumn = "1"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.history = 500
vim.opt.termguicolors = true
vim.opt.showmatch = false
vim.opt.wrap = false
vim.opt.timeoutlen = 500
vim.opt.conceallevel = 0
vim.opt.laststatus = 0
vim.opt.ch = 1
vim.opt.title = true
vim.diagnostic.config({ virtual_lines = true })
vim.opt.signcolumn = "no"

vim.cmd "set nofoldenable"
vim.cmd "let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']"

vim.g.gitblame_date_format = '%r'
vim.g.gitblame_enabled = 0
vim.g.dap_virtual_text = true
vim.g["prettier#autoformat"] = 0

vim.g.copilot_node_command = "~/.nvm/versions/node/v18.9.0/bin/node"
