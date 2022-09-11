require("toggleterm").setup{
    open_mapping = [[<Leader>u]],
    size = 20,
    start_in_insert = true,
    close_on_exit = true,
    auto_scroll = true,
    terminal_mappings = true,
    insert_mappings = false,
    direction = 'float',
    autochdir = true,

    float_opts = {
        border = 'curved',
    }
}
