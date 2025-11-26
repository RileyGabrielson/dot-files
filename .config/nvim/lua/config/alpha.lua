local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local inspire = require("inspire")
local quote = inspire.get_quote()

-- local header = {
-- 	"                                                     ",
-- 	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
-- 	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
-- 	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
-- 	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
-- 	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
-- 	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
-- 	"                                                     ",
-- }

local top_divider = {
	[[┌─────═━──━═───────────────────────────────────────────────────────────────┐]],
}
local bottom_divider = {
	[[└───────────────────────────────────────────────────────────────═━──━═─────┘]],
}

-- Get current window height and subtract UI elements
local window_height = vim.api.nvim_win_get_height(0)
-- Subtract 4 lines for UI elements (status line, command line, etc.)
local available_height = window_height - 4

-- Calculate the height of our content
local top_divider_height = #top_divider
local bottom_divider_height = #bottom_divider
local centered_quote = inspire.center_text(quote.text, quote.author, 78, 12, 60)
local quote_height = #centered_quote

-- Total content height
local content_height = top_divider_height + quote_height + bottom_divider_height

-- Calculate remaining space and split it for padding
local remaining_height = available_height - content_height
local vertical_padding = math.max(0, math.floor(remaining_height / 2))

local final_header = {}

for _ = 1, vertical_padding, 1 do
	table.insert(final_header, "")
end

for _, line_text in pairs(top_divider) do
	table.insert(final_header, line_text)
end

for _, line_text in pairs(centered_quote) do
	table.insert(final_header, line_text)
end

for _, line_text in pairs(bottom_divider) do
	table.insert(final_header, line_text)
end

-- Calculate bottom padding (remaining space after top padding)
local bottom_padding = remaining_height - vertical_padding

for _ = 1, bottom_padding, 1 do
	table.insert(final_header, "")
end

-- Set header
dashboard.section.header.val = final_header

-- Set menu
dashboard.section.buttons.val = {
	-- dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
	-- dashboard.button("f", "  > Find file", ":FzfLua files<CR>"),
	-- dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
	-- dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)
