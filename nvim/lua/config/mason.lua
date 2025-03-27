local settings = {
  ui = {
    border = "none",
  },
  log_level = vim.log.levels.ERROR,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
