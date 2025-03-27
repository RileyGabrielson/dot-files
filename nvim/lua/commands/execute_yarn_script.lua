local harpoon_tmux = require("harpoon.tmux")
local jest_coverage = require("commands.jest_coverage")

local execute_yarn_script = function()
	local package_json_path = vim.fn.getcwd() .. "/package.json"
	local command = "cat " .. package_json_path .. " | jq .scripts | jq 'keys'"
	local scripts = { "Test Current File (Coverage)" }

	vim.fn.jobstart(command, {
		on_stdout = function(_, script_options)
			local output = vim.fn.join(script_options)
			for w in output:gmatch("%S+") do
				if w ~= "[" and w ~= "]" then
					local no_commas = w:gsub(",", "")
					local no_paren = no_commas:gsub('"', "")
					table.insert(scripts, no_paren)
				end
			end

			if #scripts ~= 1 then
				vim.ui.select(scripts, {
					prompt = "Choose Yarn Script:",
				}, function(input)
					if input ~= nil then
						if input == "Test Current File (Coverage)" then
							jest_coverage()
						else
							vim.ui.input({ prompt = "Additional Arguments: " }, function(args)
								harpoon_tmux.sendCommand(1, "yarn " .. input .. " " .. args .. "\n")
								harpoon_tmux.gotoTerminal(1)
							end)
						end
					end
				end)
			else
				vim.notify(
					"No scripts found in `" .. package_json_path .. "`",
					"warn",
					{ title = "No Scripts Found", timeout = 5000 }
				)
			end
		end,
	})
end

return execute_yarn_script
