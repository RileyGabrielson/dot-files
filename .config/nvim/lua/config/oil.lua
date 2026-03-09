-- helper function to parse output
local function parse_output(proc)
	local result = proc:wait()
	local ret = {}
	if result.code == 0 then
		for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
			-- Remove trailing slash
			line = line:gsub("/$", "")
			ret[line] = true
		end
	end
	return ret
end

-- build git status cache
local function new_git_status()
	return setmetatable({}, {
		__index = function(self, key)
			local ignore_proc = vim.system(
				{ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
				{
					cwd = key,
					text = true,
				}
			)
			local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
				cwd = key,
				text = true,
			})
			local ret = {
				ignored = parse_output(ignore_proc),
				tracked = parse_output(tracked_proc),
			}

			rawset(self, key, ret)
			return ret
		end,
	})
end
local git_status = new_git_status()

-- Clear git status cache on refresh
local refresh = require("oil.actions").refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
	git_status = new_git_status()
	orig_refresh(...)
end

require("oil").setup({
	view_options = {
		show_hidden = true,
		skip_confirm_for_simple_edits = true,
		highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
			if is_hidden then
				return "NoiceCmdlinePopupBorder"
			end
			-- Also highlight folders that are not tracked by git
			if entry.type == "directory" then
				local bufnr = vim.api.nvim_get_current_buf()
				local dir = require("oil").get_current_dir(bufnr)
				if dir then
					local folder_name = entry.name
					local tracked = git_status[dir].tracked
					-- Check if directory itself is tracked (unlikely) or if any files within it are tracked
					local has_tracked_files = tracked[folder_name]
					if not has_tracked_files then
						-- Check if any tracked file path starts with folder_name/
						for tracked_path, _ in pairs(tracked) do
							if vim.startswith(tracked_path, folder_name .. "/") then
								has_tracked_files = true
								break
							end
						end
					end
					if not has_tracked_files then
						return "NoiceCmdlinePopupBorder"
					end
				end
			end
			return nil
		end,
		is_hidden_file = function(name, bufnr)
			local dir = require("oil").get_current_dir(bufnr)
			local is_dotfile = vim.startswith(name, ".") and name ~= ".."
			-- if no local directory (e.g. for ssh connections), just hide dotfiles
			if not dir then
				return is_dotfile
			end
			-- dotfiles are considered hidden unless tracked
			if is_dotfile then
				return not git_status[dir].tracked[name]
			else
				-- Check if file is gitignored
				return git_status[dir].ignored[name]
			end
		end,
	},
})
