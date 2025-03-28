local telescope = require("telescope")

telescope.setup({
	defaults = {
		entry_prefix = "・",
		wrap_results = true,
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
			n = {},
		},
		layout_strategy = "vertical",
		layout_config = {
			height = 0.95,
			width = 0.95,
		},
	},
	pickers = {
		["builtin.live_grep"] = {
			disable_coordinates = true,
		},
	},
	extensions = {
		fzf = {
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

telescope.load_extension("fzf")

local custom_functions = {}
local utils = require("telescope.utils")
local builtin = require("telescope.builtin")

custom_functions.project_files = function()
	local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
	if ret == 0 then
		builtin.git_files()
	else
		builtin.find_files()
	end
end

return custom_functions
