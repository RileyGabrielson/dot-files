local vscode = require('vscode')

function mysplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

local open_vscode_repository = function()
  local command = "find ~/r ~/r/exploration ~/r/games ~/r/work-other ~/r/blackcat -maxdepth 1 -type d"
  local home = vim.fn.expand('$HOME')
  local obj = vim.system(
    {
      "find",
      home .. "/r",
      home .. "/r/games",
      home .. "/r/work-other",
      home .. "/r/blackcat",
      "-maxdepth",
      "1",
      "-type",
      "d"
    }, 
    { text = true }
  ):wait()

  local rawText = obj.stdout
  local repositories = mysplit(rawText, '\n')
  vim.ui.select(repositories, {
    prompt = "Choose Repository:"
  }, function(choice)
    if choice == nil then
      return
    end
    vscode.eval_async(
      "let { Uri, commands } = require('vscode');" .. 
      "let uri = Uri.file('" .. choice .. "');\n" .. 
      "let success = await commands.executeCommand('vscode.openFolder', uri);"
    )
  end)
end

return open_vscode_repository
