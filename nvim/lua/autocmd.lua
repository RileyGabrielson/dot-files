vim.cmd[[
augroup prettier_format
autocmd!
au BufWritePre *.js,*.jsx,*.ts,*.tsx silent! Prettier
augroup END
]]

vim.cmd[[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]]
