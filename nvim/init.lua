local try_load_lazy = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end


require "options"

try_load_lazy()
local plugins = require "lazy_plugins"
require('lazy').setup(plugins, {})

require "autocmd"
require "lsp"
require "dap_adapters"
require "status_column"
require "colorscheme"
require "gui"
