require("dressing").setup({
  input = {
    relative = "editor",
    insert_only = false,
    mappings = {
      n = {
        ["<S-Esc>"] = "Close",
        ["<CR>"] = "Confirm",
      },
      i = {
        ["<S-Esc>"] = "Close",
        ["<CR>"] = "Confirm",
        ["<Up>"] = "HistoryPrev",
        ["<Down>"] = "HistoryNext",
      },
    },
  },
  select = {
    builtin = {
      min_width = {70, 0.5}
    },
    fzf = {
      window = {
        width = 0.8,
      }
    }
  },
})
