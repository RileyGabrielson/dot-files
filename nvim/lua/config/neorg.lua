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
        default_keybinds = false,
        hook = function(keybinds)
           keybinds.map("norg", "n", "gt", ":tabnext<CR>")
           keybinds.remap_event("norg", "n", "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle")
        end
      }
    },
    ["core.norg.esupports.metagen"] = {
      config = {
        type = 'auto',
      }
    },
    ["core.export"] = {}
  },
}
