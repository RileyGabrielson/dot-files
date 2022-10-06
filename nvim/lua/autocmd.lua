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

local show_yanks = {'TextYankPost', '*', 'lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})'}
local formatPrettier = {'BufWritePre', '*.js,*.jsx,*.ts,*.tsx', 'silent! PrettierAsync'}
local neorgConcealOnEnter = {'BufEnter', '*.norg', "set conceallevel=1"}
local neorgRevealOnLeave = {'BufLeave', '*.norg', "set conceallevel=0"}
local closeNvimTree = {'BufLeave', '*NvimTree*', "NvimTreeClose"}

define_augroups({
    _general_settings = {
        show_yanks,
        neorgConcealOnEnter,
        neorgRevealOnLeave,
        closeNvimTree,
    },
    _auto_formatters = {
        formatPrettier,
    }
})
