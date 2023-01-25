vim.opt.background = "dark"
vim.o.background = "dark"

require("gruvbox").setup({
  contrast = "hard", -- can be "hard", "soft" or empty string
  inverse = true,
  invert_selection = false,
  italic = false,
})
vim.cmd("colorscheme gruvbox")
vim.cmd("hi DiffAdd guifg=None guibg=#4C5E4F ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffDelete guifg=None guibg=#9C5351 ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffChange guifg=None guibg=None ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffText guifg=#000000 guibg=#D79921 ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi CursorLineNr guifg=#D79921 guibg=None ctermbg=None ctermfg=None gui=None cterm=None")

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
