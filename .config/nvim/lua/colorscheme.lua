vim.opt.background = "dark"

vim.cmd("colorscheme gruvbox")

vim.cmd("hi DiffChange guifg=None guibg=None ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffText guifg=None guibg=#635029 ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffAdd guifg=None guibg=#3C3C25 ctermbg=None ctermfg=None gui=None cterm=None")
vim.cmd("hi DiffDelete guifg=None guibg=#462726 ctermbg=None ctermfg=None gui=None cterm=None")

vim.cmd("hi IndentBlanklineChar guifg=#504945")
vim.cmd("hi IndentBlanklineContextChar guifg=#7c6f64")

vim.cmd("hi CursorLineNr guifg=#D79921 guibg=None ctermbg=None ctermfg=None gui=None cterm=None")

vim.cmd("hi NoiceCmdlinePopupBorder guifg=#7c6f64")
vim.cmd("hi NoiceCmdlineIconCmdline guifg=#b8bb26")
vim.cmd("hi NoiceCmdlineIcon guifg=#b8bb26")
vim.cmd("hi NoiceCmdlinePrompt guifg=#b8bb26")
vim.cmd("hi Normal ctermbg=NONE guibg=NONE")

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.cmd("hi RenderMarkdownH1Bg guifg=#D79921 guibg=#2E2E2E")
vim.cmd("hi RenderMarkdownH2Bg guifg=#D79921 guibg=#2E2E2E")
vim.cmd("hi RenderMarkdownH3Bg guifg=#D79921 guibg=#2E2E2E")
vim.cmd("hi RenderMarkdownH4Bg guifg=#D79921 guibg=#2E2E2E")
vim.cmd("hi RenderMarkdownH5Bg guifg=#D79921 guibg=#2E2E2E")
vim.cmd("hi RenderMarkdownH6Bg guifg=#D79921 guibg=#2E2E2E")

vim.cmd("hi Search guifg=#D79921 guibg=#2E2E2E")
vim.cmd("hi CurSearch guifg=#D79921 guibg=#2E2E2E")
