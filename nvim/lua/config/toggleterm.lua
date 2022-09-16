require("toggleterm").setup{
    size = 20,
    start_in_insert = true,
    close_on_exit = true,
    auto_scroll = true,
    terminal_mappings = true,
    insert_mappings = false,
    direction = 'float',
    autochdir = true,
    hide_numbers = false,
    shade_terminals = true,

    float_opts = {
        border = 'curved',
    }
}

function _G.set_terminal_keymaps()
  local opts = {silent = true}
  vim.api.nvim_set_keymap('t', '<Esc><Esc>', "<Cmd>ToggleTerm<CR>", opts)
  vim.api.nvim_set_keymap('t', '<S-Esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_set_keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.api.nvim_set_keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.api.nvim_set_keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.api.nvim_set_keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
