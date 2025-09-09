local M = {}

-- Function to get the git remote URL
local function get_git_remote_url()
	local result = vim.fn.system("git config --get remote.origin.url")
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return vim.trim(result)
end

-- Function to get the current branch
local function get_current_branch()
	local result = vim.fn.system("git rev-parse --abbrev-ref HEAD")
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return vim.trim(result)
end

-- Function to get the current commit hash
local function get_current_commit()
	local result = vim.fn.system("git rev-parse HEAD")
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return vim.trim(result)
end

-- Function to convert SSH URL to HTTPS URL
local function ssh_to_https(url)
	-- Convert git@github.com:user/repo.git to https://github.com/user/repo
	local https_url = url:gsub("git@([^:]+):([^/]+)/(.+)%.git", "https://%1/%2/%3")
	return https_url
end

-- Function to generate the link
local function generate_link()
	-- Get current file path relative to git root
	local file_path = vim.fn.expand("%:.")
	if file_path == "" then
		vim.notify("No file open", vim.log.levels.ERROR)
		return nil
	end

	-- Get line range for visual mode or current line
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	local line_range

	-- Check if we're in visual mode
	local mode = vim.fn.mode()
	if mode:match("[vV]") then
		-- In visual mode, use the selected range
		if start_line == end_line then
			line_range = string.format("L%d", start_line)
		else
			line_range = string.format("L%d-L%d", start_line, end_line)
		end
	else
		-- In normal mode, use current line
		line_range = string.format("L%d", end_line)
	end

	-- Get git remote URL
	local remote_url = get_git_remote_url()
	if not remote_url then
		vim.notify("Not in a git repository", vim.log.levels.ERROR)
		return nil
	end

	-- Convert SSH to HTTPS if needed
	local https_url = remote_url
	if remote_url:match("^git@") then
		https_url = ssh_to_https(remote_url)
	end

	-- Get current branch
	local branch = get_current_branch()
	if not branch then
		vim.notify("Could not determine current branch", vim.log.levels.ERROR)
		return nil
	end

	-- Generate the link
	local link
	link = string.format("%s/blob/%s/%s#%s", https_url, branch, file_path, line_range)

	return link
end

-- Function to copy link to clipboard
local function yank_link()
	local link = generate_link()
	if not link then
		return
	end

	-- Copy to clipboard
	vim.fn.setreg("+", link)
	vim.fn.setreg("*", link) -- Also copy to primary selection on Linux

	-- Show notification
	vim.notify("Copied link to clipboard: " .. link, vim.log.levels.INFO)
end

-- Function to copy link with commit hash instead of branch
local function yank_link_commit()
	-- Get current file path relative to git root
	local file_path = vim.fn.expand("%:.")
	if file_path == "" then
		vim.notify("No file open", vim.log.levels.ERROR)
		return nil
	end

	-- Get line range for visual mode or current line
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	local line_range

	-- Check if we're in visual mode
	local mode = vim.fn.mode()
	if mode:match("[vV]") then
		-- In visual mode, use the selected range
		if start_line == end_line then
			line_range = string.format("L%d", start_line)
		else
			line_range = string.format("L%d-L%d", start_line, end_line)
		end
	else
		-- In normal mode, use current line
		line_range = string.format("L%d", end_line)
	end

	-- Get git remote URL
	local remote_url = get_git_remote_url()
	if not remote_url then
		vim.notify("Not in a git repository", vim.log.levels.ERROR)
		return nil
	end

	-- Convert SSH to HTTPS if needed
	local https_url = remote_url
	if remote_url:match("^git@") then
		https_url = ssh_to_https(remote_url)
	end

	-- Get current commit hash
	local commit = get_current_commit()
	if not commit then
		vim.notify("Could not determine current commit", vim.log.levels.ERROR)
		return nil
	end

	-- Generate the link with commit hash
	local link = string.format("%s/blob/%s/%s#%s", https_url, commit, file_path, line_range)

	-- Copy to clipboard
	vim.fn.setreg("+", link)
	vim.fn.setreg("*", link)

	-- Show notification
	vim.notify("Copied link (commit) to clipboard: " .. link, vim.log.levels.INFO)

	-- Also echo the link
	vim.cmd("echo 'Copied to clipboard (commit): " .. link .. "'")
end

-- Export functions
M.yank_link = yank_link
M.yank_link_commit = yank_link_commit
M.generate_link = generate_link

return M
