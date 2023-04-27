local jest_coverage = require("commands.jest_coverage")

local function notify_output(command, opts)
  local output = ""
  local notification
  local notify = function(msg, level, timeout)
    local notify_opts = vim.tbl_extend(
      "keep",
      opts or {timeout = timeout},
      { title = table.concat(command, " "), replace = notification }
    )
    notification = vim.notify(msg, level, notify_opts)
  end

  notify("", "info", false);
  local on_data = function(_, data)
    output = output .. table.concat(data, "\n")
    notify(output, "info", false)
  end

  vim.fn.jobstart(command, {
    on_stdout = on_data,
    on_stderr = on_data,
    on_exit = function(_, code)
      if #output == 0 then
        notify("No output of command, exit code: " .. code, "warn", 5000)
      else
        notify(output, "info", 3000)
      end
    end,
  })
end

local execute_yarn_script = function()
  local package_json_path = vim.fn.getcwd() .. '/package.json';
  local command = 'cat ' .. package_json_path .. " | jq .scripts | jq 'keys'"
  local scripts = { "Test (Coverage)" }

  vim.fn.jobstart(command, {
    on_stdout = function(channel_name, script_options)
      local output = vim.fn.join(script_options)
      for w in output:gmatch("%S+") do
        if w ~= '[' and w ~= ']' then
          local no_commas = w:gsub(",", "");
          local no_paren = no_commas:gsub('"', '');
          table.insert(scripts, no_paren);
        end
      end

      if #scripts ~= 1 then
        vim.ui.select(
          scripts,
          {
            prompt = 'Choose Yarn Script:',
          },
          function(input)
            if input ~= nil then
              if input == "Test (Coverage)" then
                jest_coverage()
              else
                vim.ui.input({ prompt = 'Additional Arguments: '}, function(args)
                  notify_output({'yarn', input, args});
                end)
              end

            end
          end
        )
      else
        vim.notify("No scripts found in `" .. package_json_path .. "`", "warn", {title = "No Scripts Found", timeout = 5000})
      end
    end,
  })

end

return execute_yarn_script
