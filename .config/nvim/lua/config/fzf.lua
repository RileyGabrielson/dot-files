local fzf = require("fzf-lua")
local actions = fzf.actions

fzf.setup({
	"hide",
	fzf_opts = { ["--cycle"] = true },
	winopts = {
		preview = {
			vertical = "up:70%",
			layout = "vertical",
		},
	},
	keymap = {
		builtin = {
			true,
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
			["<C-z>"] = actions.sym_lsym,
		},
		fzf = {
			true,
			["ctrl-q"] = "select-all+accept",
			["ctrl-d"] = "preview-page-down",
			["ctrl-u"] = "preview-page-up",
			["ctrl-z"] = actions.sym_lsym,
		},
	},
})

fzf.register_ui_select()
