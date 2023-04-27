require("noice").setup({

  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    long_message_to_split = true, -- long messages will be sent to a split
    lsp_doc_border = false, -- add a border to hover docs and signature help
    inc_rename = true,
  },

  cmdline = {
    format = {
      cdo = { pattern = "^:cdo", icon = "cdo", title="QUICK FIX" },
      cmdline = { pattern = "^:", icon = ">_", lang = "vim", title="COMMAND" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash", title="FILTER" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "", title="HELP" },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua", title="LUA" },
      substitute = { pattern = '^:%%s/', icon = "%s/", lang = "regex", title="SUBSTITUTE" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
    }
  },

  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },

  notify = {
    enabled = false,
  },

  views = {
    cmdline_popup = {
      position = {
        row = 25,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 28,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
})
