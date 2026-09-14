-- GhostText edits browser textareas inside the nvim instance that's already
-- running, instead of embedding nvim in the page like firenvim does.
--
-- Setup: install the browser extension from https://ghosttext.fregante.com,
-- then click its toolbar button while a text field is focused. The field opens
-- in a new tab here and syncs on every keystroke -- no :w needed. Close the
-- buffer (or click the extension button again) to disconnect.
--
-- nvim-ghost downloads its server binary on first launch, so the initial start
-- after install is slow.

-- Skip the "server started/stopped" chatter on every nvim launch.
vim.g.nvim_ghost_super_quiet = 1

-- Must match the port in the GhostText extension settings.
vim.g.nvim_ghost_server_port = 4001

-- nvim-ghost's server runs `doau nvim_ghost_user_autocommands User <hostname>`
-- once it fills the buffer, so the augroup name is load-bearing.
local group = vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", { clear = true })

-- The extension reports a syntax for code editors only; forge comment boxes
-- come through as plain text, so name them here.
vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = {
		"github.com",
		"*.github.com",
		"gitlab.com",
		"*.gitlab.com",
		"git.tcncloud.net",
		"*.reddit.com",
		"*.stackoverflow.com",
	},
	callback = function(args)
		vim.bo[args.buf].filetype = "markdown"
	end,
})
