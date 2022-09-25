local custom_theme = require'lualine.themes.ayu_dark'

custom_theme.normal.a.bg = '#7aa2f7'
custom_theme.insert.a.bg = '#e0af68'
custom_theme.visual.a.bg = '#9d7cd8'

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = custom_theme,
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
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
    lualine_b = {
      {
        'filename',
        path = 1,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
