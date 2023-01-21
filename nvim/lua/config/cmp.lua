local cmp = require("cmp")

if(cmp == nil) then return end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<C-j>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ['<C-k>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
    }),

    -- the order you put these in are the ranking you want it shown up
    sources = cmp.config.sources({
        {name = "nvim_lua"},
        {name = "path"},
        {name = "nvim_lsp"},
    }),

    formatting = {
      format = function(entry, vim_item)

        if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
          vim_item.menu = entry.completion_item.detail
        else
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
        end

        return vim_item
      end
    },
})

