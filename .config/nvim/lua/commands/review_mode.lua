local M = {}

-- ISSUES
--   delete something with spaces, algorithm gets confused on where those should be
--   list of files that have changed
--   accept by block

local state = {
	active = false,
	baseline_content = {},
	virtual_text_namespace = vim.api.nvim_create_namespace("review_mode"),
	file_states = {},
}

local function split(value, delimiter)
	local from = 1
	local result = {}
	local delim_from, delim_to = string.find(value, delimiter, from)
	while delim_from do
		table.insert(result, string.sub(value, from, delim_from - 1))
		from = delim_to + 1
		delim_from, delim_to = string.find(value, delimiter, from)
	end
	table.insert(result, string.sub(value, from))
	return result
end

local function capture_initial_baseline_content()
	local baseline = {}

	local changed_files_output = vim.fn.system("git status -s")
	local changed_files = {}
	for line in changed_files_output:gmatch("[^\r\n]+") do
		local parsed_line = line:sub(4)
		table.insert(changed_files, parsed_line)
	end

	for _, file_name in ipairs(changed_files) do
		local content = vim.fn.system("cat " .. file_name)
		local lines = split(content, "\n")

		baseline[file_name] = lines
	end

	return baseline
end

local function myers_diff_algorithm(a, b)
	local m, n = #a, #b
	local dp = {}

	for i = 0, m do
		dp[i] = {}
		for j = 0, n do
			if i == 0 or j == 0 then
				dp[i][j] = 0
			elseif a[i] == b[j] then
				dp[i][j] = dp[i - 1][j - 1] + 1
			else
				dp[i][j] = math.max(dp[i - 1][j], dp[i][j - 1])
			end
		end
	end

	return dp
end

local function get_diff_operations(baseline, current)
	local dp = myers_diff_algorithm(baseline, current)
	local operations = {}
	local i, j = #baseline, #current

	while i > 0 or j > 0 do
		if i > 0 and j > 0 and baseline[i] == current[j] then
			i = i - 1
			j = j - 1
		elseif j > 0 and (i == 0 or dp[i][j - 1] >= dp[i - 1][j]) then
			table.insert(operations, 1, { type = "add", line = current[j], pos = j })
			j = j - 1
		elseif i > 0 then
			table.insert(operations, 1, { type = "remove", line = baseline[i], pos = i })
			i = i - 1
		end
	end

	return operations
end

local function get_file_diff(baseline_lines, current_lines)
	if not baseline_lines then
		return nil
	end

	local operations = get_diff_operations(baseline_lines, current_lines)

	if #operations == 0 then
		return {}
	end

	-- Group consecutive operations into hunks
	local hunks = {}
	local current_hunk = nil
	local last_op = nil

	for _, op in ipairs(operations) do
		if not current_hunk then
			current_hunk = {
				old_start = op.pos,
				new_start = op.pos,
				old_lines = {},
				new_lines = {},
			}
		end

		if last_op and op.pos > last_op.pos + 1 then
			table.insert(hunks, current_hunk)
			current_hunk = {
				old_start = op.pos,
				new_start = op.pos,
				old_lines = {},
				new_lines = {},
			}
		end

		if op.type == "add" then
			table.insert(current_hunk.new_lines, {
				content = op.line,
				line_num = op.pos,
			})
		elseif op.type == "remove" then
			table.insert(current_hunk.old_lines, {
				content = op.line,
				line_num = op.pos,
			})
		end

		last_op = op
	end

	if current_hunk and (#current_hunk.old_lines > 0 or #current_hunk.new_lines > 0) then
		table.insert(hunks, current_hunk)
	end

	return hunks
end

local function display_virtual_text_for_buffer(bufnr)
	local filepath = vim.api.nvim_buf_get_name(bufnr)
	local relative_path = vim.fn.fnamemodify(filepath, ":.")

	if not state.baseline_content[relative_path] then
		return
	end

	vim.api.nvim_buf_clear_namespace(bufnr, state.virtual_text_namespace, 0, -1)

	-- Get current buffer content and compare with baseline
	local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local hunks = get_file_diff(state.baseline_content[relative_path], current_lines)

	if not hunks or #hunks == 0 then
		return
	end

	for _, hunk in ipairs(hunks) do
		local old_virt_lines = {}

		for _, old_line in ipairs(hunk.old_lines) do
			if old_line.content == "" then
				table.insert(old_virt_lines, { { "-", "DiffDelete" } })
			else
				table.insert(old_virt_lines, { { old_line.content, "DiffDelete" } })
			end
		end

		if hunk.new_start < #current_lines then
			vim.api.nvim_buf_set_extmark(bufnr, state.virtual_text_namespace, hunk.new_start - 1, 0, {
				virt_lines = old_virt_lines,
				virt_lines_above = true,
			})
		end

		-- Highlight new lines (added) in the buffer with DiffAdd background
		for new_idx, _ in ipairs(hunk.new_lines) do
			local target_line = hunk.new_start + new_idx - 2
			if target_line >= 0 and target_line < vim.api.nvim_buf_line_count(bufnr) then
				vim.api.nvim_buf_set_extmark(bufnr, state.virtual_text_namespace, target_line, 0, {
					end_row = target_line + 1,
					hl_group = "DiffAdd",
					hl_eol = true,
				})
			else
			end
		end
	end

	state.file_states[bufnr] = {
		filepath = relative_path,
		hunks = hunks,
		virtual_text_displayed = true,
	}
end

local function accept_changes()
	local bufnr = vim.api.nvim_get_current_buf()
	local filepath = vim.api.nvim_buf_get_name(bufnr)
	local relative_path = vim.fn.fnamemodify(filepath, ":.")
	if state.file_states[bufnr] then
		vim.api.nvim_buf_clear_namespace(bufnr, state.virtual_text_namespace, 0, -1)
		state.file_states[bufnr] = nil
		state.baseline_content[relative_path] = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	else
		return
	end
end

local function cancel_changes()
	local bufnr = vim.api.nvim_get_current_buf()
	local filepath = vim.api.nvim_buf_get_name(bufnr)
	local relative_path = vim.fn.fnamemodify(filepath, ":.")

	if state.baseline_content[relative_path] then
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, state.baseline_content[relative_path])
		vim.api.nvim_buf_clear_namespace(bufnr, state.virtual_text_namespace, 0, -1)
		state.file_states[bufnr] = nil
	else
		return
	end
end

function M.start_review_mode()
	if state.active then
		return
	end

	state.active = true
	state.baseline_content = capture_initial_baseline_content()

	vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "TextChanged", "TextChangedI" }, {
		callback = function(args)
			if state.active then
				local filepath = vim.api.nvim_buf_get_name(args.buf)
				local relative_path = vim.fn.fnamemodify(filepath, ":.")
				local is_git_file = vim.fn.system("git ls-files " .. vim.fn.shellescape(relative_path)):gsub("%s+", "")
					~= ""

				if not state.baseline_content[relative_path] and filepath ~= "" and is_git_file then
					local raw_content = vim.fn.system("git show HEAD:" .. relative_path .. " | cat")
					local raw_content_lines = split(raw_content, "\n")
					state.baseline_content[relative_path] = raw_content_lines
				end

				if is_git_file then
					display_virtual_text_for_buffer(args.buf)
				end
			end
		end,
		group = vim.api.nvim_create_augroup("ReviewMode", { clear = true }),
	})

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			display_virtual_text_for_buffer(bufnr)
		end
	end
end

function M.stop_review_mode()
	if not state.active then
		return
	end

	state.active = false
	state.baseline_content = {}
	state.file_states = {}

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		vim.api.nvim_buf_clear_namespace(bufnr, state.virtual_text_namespace, 0, -1)
	end

	vim.api.nvim_del_augroup_by_name("ReviewMode")
end

vim.api.nvim_create_user_command("ReviewModeStart", M.start_review_mode, {})
vim.api.nvim_create_user_command("ReviewModeStop", M.stop_review_mode, {})

vim.keymap.set("n", "<leader>aa", accept_changes, { desc = "Accept changes in current buffer" })
vim.keymap.set("n", "<leader>ac", cancel_changes, { desc = "Cancel changes in current buffer" })

return M
