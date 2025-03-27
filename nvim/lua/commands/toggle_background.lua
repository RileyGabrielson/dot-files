local background_is_visible = true

local function toggle_background()
	if background_is_visible then
		background_is_visible = false
		vim.cmd("hi Normal guibg=#282828")
	else
		background_is_visible = true
		vim.cmd("hi Normal guibg=NONE")
	end
end

return toggle_background
