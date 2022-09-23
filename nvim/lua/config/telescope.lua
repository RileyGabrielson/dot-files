local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
      }
    },
    layout_config = {
      horizontal = { width = .9, preview_width = .2 },
    }
  },
  pickers = {},
  extensions = {
    fzf = {
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
  }
}

telescope.load_extension('fzf')

local custom_functions = {}

custom_functions.project_files = function()
  local opts = {}
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

return custom_functions
