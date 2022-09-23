require('nvim_comment').setup({
  comment_empty = false,
  create_mappings = false,
})

require('nvim_comment').setup({
    comment_empty = false,
    hook = function()
        if vim.bo.filetype == 'typescriptreact' then
            require('ts_context_commentstring.internal').update_commentstring({})
        end
    end
})

