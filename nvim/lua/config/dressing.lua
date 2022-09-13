require("dressing").setup {
  input = { relative = "editor" },

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

  fzf_lua = {
    winopts = {
      width = 0.5,
      height = 0.7,
    },
  },
}
