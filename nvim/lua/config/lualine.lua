local custom_theme = require("lualine.themes.gruvbox")

-- component_separators = { left = '', right = ''},
--     section_separators = { left = '', right = ''},

custom_theme.normal.c.bg = "#3A3A3A"
custom_theme.normal.c.fg = "#A89984"
custom_theme.insert.c.bg = "#3A3A3A"
custom_theme.insert.c.fg = "#A89984"
custom_theme.visual.c.bg = "#3A3A3A"
custom_theme.visual.c.fg = "#A89984"

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = custom_theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 50,
			tabline = 50,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			require("tmux-status").tmux_session,
		},
		lualine_b = {
			require("tmux-status").tmux_windows,
		},
		lualine_c = {},
	},
	inactive_sections = {},
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				path = 1,
			},
			"diagnostics",
		},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

vim.cmd("hi tmux_status_session guifg=#a8a8a8 guibg=#626262")
vim.cmd("hi tmux_status_window_active guifg=#D79921 guibg=#4E4E4E")
vim.cmd("hi tmux_status_window_inactive guifg=#f9d8b4 guibg=#4E4E4E")
vim.cmd("hi tmux_status_window_inactive_recent guifg=#f9d8b4 guibg=#4E4E4E")
