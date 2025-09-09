local custom_theme = require("lualine.themes.gruvbox")

custom_theme.normal.c.bg = "#3A3A3A"
custom_theme.normal.c.fg = "#A89984"
custom_theme.insert.c.bg = "#3A3A3A"
custom_theme.insert.c.fg = "#A89984"
custom_theme.visual.c.bg = "#3A3A3A"
custom_theme.visual.c.fg = "#A89984"
custom_theme.command.c.bg = "#3A3A3A"
custom_theme.command.c.fg = "#A89984"

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
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 75,
		},
	},
	sections = {
		lualine_a = {
			require("tmux-status").tmux_session,
		},
		lualine_b = {
			require("tmux-status").tmux_windows,
		},
		lualine_c = {
			"diagnostics",
		},
		lualine_x = {
			{ "location" },
		},
		lualine_y = {
			{ "filename", path = 1 },
		},
		lualine_z = {},
	},
	inactive_sections = {},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

vim.cmd("hi tmux_status_session guifg=#c6c6c6 guibg=#626262")
vim.cmd("hi tmux_status_window_active guifg=#D79921 guibg=#4E4E4E")
vim.cmd("hi tmux_status_window_inactive guifg=#c6c6c6 guibg=#4E4E4E")
vim.cmd("hi tmux_status_window_inactive_recent guifg=#c6c6c6 guibg=#4E4E4E")
