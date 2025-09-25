local M = {}

-- GitLab plugin commands with descriptions
local gitlab_commands = {
	{
		name = "approve",
		description = "Approve merge request",
		command = "require'gitlab'.approve()",
	},
	{
		name = "create_comment",
		description = "Create comment on merge request",
		command = "require'gitlab'.create_comment()",
	},
	{
		name = "choose_merge_request",
		description = "Choose merge request to review",
		command = "require'gitlab'.choose_merge_request()",
	},
	{
		name = "review",
		description = "Review merge request",
		command = "require'gitlab'.review()",
	},
	{
		name = "summary",
		description = "Show merge request summary",
		command = "require'gitlab'.summary()",
	},
	{
		name = "revoke",
		description = "Revoke approval",
		command = "require'gitlab'.revoke()",
	},
	{
		name = "open_in_browser",
		description = "Open merge request in browser",
		command = "require'gitlab'.open_in_browser()",
	},
	{
		name = "add_reviewer",
		description = "Add reviewer to merge request",
		command = "require'gitlab'.add_reviewer()",
	},
	{
		name = "delete_reviewer",
		description = "Delete reviewer from merge request",
		command = "require'gitlab'.delete_reviewer()",
	},
	{
		name = "add_assignee",
		description = "Add assignee to merge request",
		command = "require'gitlab'.add_assignee()",
	},
	{
		name = "delete_assignee",
		description = "Delete assignee from merge request",
		command = "require'gitlab'.delete_assignee()",
	},
	{
		name = "create_note",
		description = "Create note on merge request",
		command = "require'gitlab'.create_note()",
	},
	{
		name = "create_comment_suggestion",
		description = "Create comment suggestion",
		command = "require'gitlab'.create_comment_suggestion()",
	},
	{
		name = "create_multiline_comment",
		description = "Create multiline comment",
		command = "require'gitlab'.create_multiline_comment()",
	},
	{
		name = "publish_all_drafts",
		description = "Publish all draft comments",
		command = "require'gitlab'.publish_all_drafts()",
	},
	{
		name = "pipeline",
		description = "View Pipeline",
		command = "require'gitlab'.pipeline()",
	},
}

function M.gitlab_picker()
	local fzf_lua = require("fzf-lua")

	-- Prepare items for fzf-lua
	local items = {}
	for _, cmd in ipairs(gitlab_commands) do
		table.insert(items, cmd.name .. " | " .. cmd.description)
	end

	-- Create fzf-lua picker
	fzf_lua.fzf_exec(items, {
		prompt = "GitLab Commands> ",
		actions = {
			["default"] = function(selected, _)
				if selected and #selected > 0 then
					-- Extract command name from selection
					local command_name = selected[1]:match("^([^|]+)")
					if command_name then
						command_name = command_name:gsub("%s+$", "") -- trim whitespace

						-- Find and execute the corresponding command
						for _, cmd in ipairs(gitlab_commands) do
							if cmd.name == command_name then
								vim.cmd("lua " .. cmd.command)
								break
							end
						end
					end
				end
			end,
		},
	})
end

return M
