local function edit_repo()
  local command = 'ls ~/r';
  local directories = {"dot-files"};

  local function split(inputstr)
    for str in inputstr:gmatch("%S+") do
      table.insert(directories, str)
    end
  end

  vim.fn.jobstart(command, {
    on_stdout = function(_, data)
      local all_directories = vim.fn.join(data, " ");
      split(all_directories);
      vim.ui.select(
        directories,
        { prompt = 'Choose Repository:' },
        function(input)
          if input ~= nil then
            if input == "dot-files" then
              vim.cmd("e ~/dot-files")
            else
              vim.cmd("e ~/r/" .. input)
            end
          end
        end
      )
    end
  })
end

return edit_repo
