local M = {}

local function get_file_path()
	local file_path = vim.fn.expand("%:.")
	if file_path == "" then
		return nil;
	end

	if string.find(file_path, "commons/ui") then
    return file_path:gsub("^(commons/)ui/(.*).tsx?$", "@neo/%1%2");
	elseif string.find(file_path, "ui/operator/src") then
		return file_path:gsub("^ui(.*).tsx?$", "@neo%1")
	else
    return file_path;
	end
end

local function copy_file_path()
	local file_path = get_file_path();
	if file_path == "" then
		vim.cmd("echoerr 'No file path'")
		return
	end
  vim.fn.setreg("+", file_path)
  vim.cmd("echo 'Copied file path to clipboard'")
end

M.copy_file_path = copy_file_path
M.get_file_path = get_file_path

return M
