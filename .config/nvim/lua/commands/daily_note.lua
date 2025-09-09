local function get_today_date()
	return os.date("%Y-%m-%d")
end

local function get_daily_notes_dir()
	return vim.fn.expand("~/r/notes/daily_notes")
end

local function get_today_note_path()
	local date = get_today_date()
	local dir = get_daily_notes_dir()
	return dir .. "/" .. date .. ".md"
end

local function ensure_directory_exists(dir)
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end
end

local function open_daily_note()
	local notes_dir = get_daily_notes_dir()
	local note_path = get_today_note_path()
	ensure_directory_exists(notes_dir)

	local file_exists = vim.fn.filereadable(note_path) == 1
	vim.cmd("edit " .. vim.fn.fnameescape(note_path))

	-- If file didn't exist, add a basic template
	if not file_exists then
		local date = get_today_date()
		local template = {
			"# Daily Note - " .. date,
			"",
		}
		vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
		vim.api.nvim_win_set_cursor(0, { 1, 0 })
	end
end

return open_daily_note
