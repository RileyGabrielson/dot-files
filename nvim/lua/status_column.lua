if _G.StatusColumn then
  return
end

_G.StatusColumn = {
  display = {
    line = function()
      local lnum = tostring(vim.v.lnum)
      if #lnum == 1 then
        return " " .. lnum
      else
        return lnum
      end
    end,
  },

  sections = {
    sign_column = {
      [[%s]]
    },
    line_number = {
      [[%=%{v:lua.StatusColumn.display.line()}]]
    },
    spacing     = {
      [[ ]]
    },
    border      = {
      [[%#StatusColumnBorder#]], -- HL
      [[▐]],
    },
    padding     = {
      [[%#StatusColumnBuffer#]], -- HL
      [[ ]],
    },
  },

  build = function(tbl)
    local statuscolumn = {}

    for _, value in ipairs(tbl) do
      if type(value) == "string" then
        table.insert(statuscolumn, value)
      elseif type(value) == "table" then
        table.insert(statuscolumn, StatusColumn.build(value))
      end
    end

    return table.concat(statuscolumn)
  end,

  set_window = function(value)
    vim.defer_fn(function()
      vim.api.nvim_win_set_option(vim.api.nvim_get_current_win(), "statuscolumn", value)
    end, 1)
  end
}

vim.opt.statuscolumn = StatusColumn.build({
  StatusColumn.sections.sign_column,
  StatusColumn.sections.line_number,
  StatusColumn.sections.spacing,
  StatusColumn.sections.border,
  StatusColumn.sections.padding
})
