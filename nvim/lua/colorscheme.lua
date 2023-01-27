vim.opt.background = "dark"

vim.cmd("colorscheme gruvbox")

vim.cmd("hi DiffChange guifg=None guibg=#3C3836 ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffText guifg=None guibg=#504945 ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffAdd guifg=None guibg=#3C3C25 ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffDelete guifg=None guibg=#462726 ctermbg=None ctermfg=None gui=None cterm=None")

vim.cmd("hi CursorLineNr guifg=#D79921 guibg=None ctermbg=None ctermfg=None gui=None cterm=None")

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
