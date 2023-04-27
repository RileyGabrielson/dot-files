require("dressing").setup({
  input = {
    select = {
      builtin = {
        min_width = {70, 0.5}
      }
    },
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
  }
})
