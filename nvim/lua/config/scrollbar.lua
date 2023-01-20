require("scrollbar.handlers.gitsigns").setup()
require("scrollbar").setup({
  handlers = {
    gitsigns = true, -- Requires gitsigns
  },
})
