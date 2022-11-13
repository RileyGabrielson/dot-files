require("diffview").setup({
  use_icons = false,
  view = {
    merge_tool = {
      layout = "diff3_mixed"
    },
  },
  keymaps = {
    view = {
      ["<tab>"] = false,
      ["<s-tab>"] = false,
    },
    file_panel = {
      ["<tab>"] = false,
      ["<s-tab>"] = false,
    },
    file_history_panel = {
      ["<tab>"] = false,
      ["<s-tab>"] = false,
    },
    option_panel = {
      ["<tab>"] = false,
    }
  }
})
