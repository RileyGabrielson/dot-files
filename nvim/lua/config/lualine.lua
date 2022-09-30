local custom_theme = require'lualine.themes.gruvbox-material'

custom_theme.normal.c.bg = "#1D2021"

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = custom_theme,
    component_separators = { left = '|', right = '|'},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {},
  inactive_sections = {},
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        path = 1,
      },
      'diagnostics',
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
