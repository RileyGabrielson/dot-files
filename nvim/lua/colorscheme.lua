vim.opt.background = "dark"
vim.o.background = "dark"

require("gruvbox").setup({
  contrast = "hard", -- can be "hard", "soft" or empty string
  inverse = true,
  invert_selection = false,
})
vim.cmd("colorscheme gruvbox")
