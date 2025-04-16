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

local vertical_padding = 15

local final_header = {}

local centered_quote = inspire.center_text(quote.text, quote.author, 78, 12, 60)

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

for _ = 1, vertical_padding, 1 do
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
