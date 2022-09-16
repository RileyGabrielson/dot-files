require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        }
      }
    },
    ["core.presenter"] = {
      config = {
        zen_mode = "zen-mode" -- folke/zen-mode.nvim
      }
    },
    ["core.norg.concealer"] = {
      config = {
        conceal = true,
        padding = 0,
        width = "content",
      }
    },
    ["core.keybinds"] = {
      config = {
        neorg_leader = "<S-Space>"
      }
    },
    ["core.norg.esupports.metagen"] = {
      config = {
        type = 'auto',
      }
    }
  },
}
