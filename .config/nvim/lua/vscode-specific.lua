if vim.g.vscode then
	local which_key = require("which-key")

	which_key.add({
		{
			mode = { "n" },
			{ "<leader>l.", "<cmd>lua require('vscode').call('editor.action.codeAction')<CR>" },
			{ "<leader>lh", "<cmd>lua require('vscode').call('editor.action.showHover')<CR>" },
			{ "<leader>ls", "<cmd>lua require('vscode').call('editor.action.rename')<CR>" },
			{ "<leader>ld", "<cmd>lua require('vscode').call('editor.action.revealDefinition')<CR>" },
			{ "<leader>lr", "<cmd>lua require('vscode').call('editor.action.goToReferences')<CR>" },
			{ "<leader>lt", "<cmd>lua require('vscode').call('editor.action.goToTypeDefinition')<CR>" },
			{ "<leader>li", "<cmd>lua require('vscode').call('editor.action.goToImplementation')<CR>" },
			{ "<leader>f", "<cmd>lua require('vscode').call('quickgrep.action')<CR>" },
			{ "<leader>p", "<cmd>lua require('vscode').call('workbench.action.quickOpen')<CR>" },
			{ "<leader>tr", "<cmd>lua require('vscode').call('workbench.action.quickOpen')<CR>" },
			{ "<leader><Enter>", "", desc = "Alternate File Does Not Work", nowait = false, remap = false },
			{ "<leader>gb", "<cmd>lua require('vscode').call('gitlens.toggleLineBlame')<CR>" },
			{
				"<leader>wo",
				"<cmd>lua require('vscode').call('workbench.action.closePanel'); require('vscode').call('workbench.action.closeSidebar'); require('vscode').call('composer.closeComposerTab');<CR>",
			},
			{ "<leader>ef", "<cmd>lua require('vscode').call('workbench.files.action.showActiveFileInExplorer')<CR>" },
			{ "<leader>x", "<cmd>lua require('vscode').call('workbench.panel.markers.view.focus')<CR>" },
			{ "<leader>ut", "<cmd>lua require('vscode').call('testing.runAtCursor')<CR>" },
			{ "<leader>ud", "<cmd>lua require('vscode').call('testing.debugAtCursor')<CR>" },
		},
	})
end
