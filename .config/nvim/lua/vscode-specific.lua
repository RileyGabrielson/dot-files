if vim.g.vscode then
  local vscode = require('vscode')
  local which_key = require("which-key")

  vim.notify = vscode.notify
  vscode.call('workbench.action.toggleZenMode')

  which_key.add({
    {
      mode = { "n" },
      { "<C-s>", "<cmd>lua require('commands.vscode_repositories')()<CR>" },
      { "<leader>s", "<cmd>lua require('commands.repositories')()<CR>" },
      { "<leader>l.", "<cmd>lua require('vscode').call('editor.action.codeAction')<CR>" },
      { "<leader>lh", "<cmd>lua require('vscode').call('editor.action.showHover')<CR>" },
      { "<leader>ls", "<cmd>lua require('vscode').call('editor.action.rename')<CR>" },
      { "<leader>ld", "<cmd>lua require('vscode').call('editor.action.revealDefinition')<CR>" },
      { "<leader>lr", "<cmd>lua require('vscode').call('editor.action.goToReferences')<CR>" },
      { "<leader>lt", "<cmd>lua require('vscode').call('editor.action.goToTypeDefinition')<CR>" },
      { "<leader>li", "<cmd>lua require('vscode').call('editor.action.goToImplementation')<CR>" },
      { "<leader>f", "<cmd>lua require('vscode').call('find-it-faster.findWithinFiles')<CR>" },
      { "<leader>p", "<cmd>lua require('vscode').call('find-it-faster.findFiles')<CR>" },
      { "<leader>i", "<cmd>lua require('vscode').call('composer.startComposerPrompt')<CR>" },
      { "<leader>tr", "<cmd>lua require('vscode').call('find-it-faster.resumeSearch')<CR>" },
      { "<leader><Enter>", "", desc = "Alternate File Does Not Work", nowait = false, remap = false },
      { "<leader>gb", "<cmd>lua require('vscode').call('gitlens.toggleLineBlame')<CR>" },
      {
        "<leader>wo",
        "<cmd>lua require('vscode').call('workbench.action.closePanel'); require('vscode').call('workbench.action.closeSidebar'); require('vscode').call('composer.closeComposerTab');<CR>",
      },
      { "<leader>ef", "<cmd>lua require('vscode').call('workbench.files.action.showActiveFileInExplorer')<CR>" },
      { "<leader>x", "<cmd>lua require('vscode').call('workbench.panel.markers.view.focus')<CR>" },
      { "<leader>ut", "<cmd>lua require('vscode').call('workbench.action.tasks.runTask', { args = { 'Yarn Test' }})<CR>" },
      { "<leader>ud", "<cmd>lua require('vscode').call('testing.debugAtCursor')<CR>" },
      { "<leader>vo", "<cmd>lua require('vscode').call('workbench.view.scm')<CR>" },
      { "<leader>vm", "<cmd>lua require('vscode').call('gitlens.compareHeadWith')<CR>" },
      { "<leader>wh", "<cmd>lua require('vscode').call('workbench.action.navigateLeft')<CR>" },
      { "<leader>wl", "<cmd>lua require('vscode').call('workbench.action.navigateRight')<CR>" },
      { "<leader>wj", "<cmd>lua require('vscode').call('workbench.action.navigateDown')<CR>" },
      { "<leader>wk", "<cmd>lua require('vscode').call('workbench.action.navigateUp')<CR>" },
      { "<leader>z", "<cmd>lua require('vscode').call('workbench.action.toggleZenMode')<CR>" },
    },
  })
end
