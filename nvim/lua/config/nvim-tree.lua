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
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        git = {
          untracked = "●",
        },
      }
    }
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
