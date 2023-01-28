local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup{
  defaults = {
    entry_prefix = "・",
    wrap_results = true,
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
      }
    },
    layout_strategy = 'vertical',
    layout_config = {
      -- horizontal = { width = .9, preview_width = .2 },
      height = 0.95,
      width = 0.95
    }
  },
  pickers = {
    ["builtin.live_grep"] = {
      disable_coordinates = true,
    }
  },
  extensions = {
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  }
}

telescope.load_extension('fzf')

local custom_functions = {}
local utils = require('telescope.utils')
local builtin = require('telescope.builtin')

custom_functions.project_files = function()
    local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
    if ret == 0 then
        builtin.git_files()
    else
        builtin.find_files()
    end
end

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local strings = require "plenary.strings"
local entry_display = require "telescope.pickers.entry_display"
local make_entry = require "telescope.make_entry"

custom_functions.local_branches = function(opts)
  opts = opts or {}
  local format = "%(HEAD)"
    .. ">%(refname)"
    .. ">%(authorname)"
    .. ">%(upstream:lstrip=2)"
    .. ">%(committerdate:format-local:%Y/%m/%d %H:%M:%S)"
  local output =
    utils.get_os_command_output({ "git", "branch", "--format", format, opts.pattern }, opts.cwd)

  local results = {}
  local widths = {
    name = 0,
    authorname = 0,
    upstream = 0,
    committerdate = 0,
  }
  local unescape_single_quote = function(v)
    return string.gsub(v, "\\([\\'])", "%1")
  end
  local parse_line = function(line)
    local fields = vim.split(line, ">", {})
    local entry = {
      head = fields[1],
      refname = unescape_single_quote(fields[2]),
      authorname = unescape_single_quote(fields[3]),
      upstream = unescape_single_quote(fields[4]),
      committerdate = fields[5],
    }
    local prefix
    if vim.startswith(entry.refname, "refs/remotes/") then
      prefix = "refs/remotes/"
    elseif vim.startswith(entry.refname, "refs/heads/") then
      prefix = "refs/heads/"
    else
      return
    end
    local index = 1
    if entry.head ~= "*" then
      index = #results + 1
    end

    entry.name = string.sub(entry.refname, string.len(prefix) + 1)
    for key, value in pairs(widths) do
      widths[key] = math.max(value, strings.strdisplaywidth(entry[key] or ""))
    end
    if string.len(entry.upstream) > 0 then
      widths.upstream_indicator = 2
    end
    table.insert(results, index, entry)
  end
  for _, line in ipairs(output) do
    parse_line(line)
  end
  if #results == 0 then
    return
  end

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 1 },
      { width = widths.name },
      { width = widths.authorname },
      { width = widths.committerdate },
    },
  }

  local make_display = function(entry)
    return displayer {
      { entry.head },
      { entry.name, "TelescopeResultsIdentifier" },
      { entry.authorname },
      { entry.committerdate },
    }
  end

  pickers
    .new(opts, {
      prompt_title = "Git Branches",
      finder = finders.new_table {
        results = results,
        entry_maker = function(entry)
          entry.value = entry.name
          entry.ordinal = entry.name
          entry.display = make_display
          return make_entry.set_default_entry_mt(entry, opts)
        end,
      },
      sorter = conf.file_sorter(opts),
      attach_mappings = function(_, map)
        actions.select_default:replace(actions.git_checkout)
        map({ "i", "n" }, "<c-t>", actions.git_track_branch)
        map({ "i", "n" }, "<c-r>", actions.git_rebase_branch)
        map({ "i", "n" }, "<c-a>", actions.git_create_branch)
        map({ "i", "n" }, "<c-s>", actions.git_switch_branch)
        map({ "i", "n" }, "<c-d>", actions.git_delete_branch)
        map({ "i", "n" }, "<c-y>", actions.git_merge_branch)
        return true
      end,
    })
    :find()
end

return custom_functions
