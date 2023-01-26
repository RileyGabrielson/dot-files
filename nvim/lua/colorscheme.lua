vim.opt.background = "dark"

vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'mix'
vim.cmd("colorscheme gruvbox-material")
vim.cmd("hi DiffChange guifg=None guibg=None ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffText guifg=None guibg=#32293C ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi CursorLineNr guifg=#D79921 guibg=None ctermbg=None ctermfg=None gui=None cterm=None")

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
