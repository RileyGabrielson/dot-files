require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "javascript", "c_sharp", "lua", "vim", "regex", "bash", "markdown", "markdown_inline" },
  sync_install = true,
  auto_install = true,

  highlight = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  context = {
    enable = true,
  },

  pairs = {
    enable = true,
    disable = {},
    highlight_pair_events = {}, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
    highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
    goto_right_end = false, -- whether to go to the end of the right partner or the beginning
    fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
    keymaps = { goto_partner = "<leader>%" }
  },
}

