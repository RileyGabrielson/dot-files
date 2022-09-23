vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  remove_keymaps = {"<Tab>"},
  sync_root_with_cwd = true,
  view = {
    number = true,
    relativenumber = true,
    adaptive_size = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = " ",
      info = " ",
      warning = "",
      error = "",
    },
  },


})
