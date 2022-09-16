local function define_augroups(definitions) -- {{{1
    -- Create autocommand groups based on the passed definitions
    --
    -- The key will be the name of the group, and each definition
    -- within the group should have:
    --    1. Trigger
    --    2. Pattern
    --    3. Text
    -- just like how they would normally be defined from Vim itself
    for group_name, definition in pairs(definitions) do
        vim.cmd('augroup ' .. group_name)
        vim.cmd('autocmd!')

        for _, def in pairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            vim.cmd(command)
        end

        vim.cmd('augroup END')
    end
end

local nerdtree_quit_vim = {'BufEnter', '*', "if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif"}
local show_yanks = {'TextYankPost', '*', 'lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})'}
local formatPrettier = {'BufWritePre', '*.js,*.jsx,*.ts,*.tsx', 'silent! PrettierAsync'}

define_augroups({
    _general_settings = {
        show_yanks,
        nerdtree_quit_vim,
    },
    _auto_formatters = {
        formatPrettier,
    }
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

