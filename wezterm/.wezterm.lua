local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font_size = 17.2
config.audible_bell = "Disabled"
config.enable_tab_bar = false
config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"
config.window_padding = {
  left = 2,
  right = 0,
  top = 0,
  bottom = 0,
}
config.color_scheme = 'GruvboxDarkHard'
-- config.color_scheme = 'tokyonight_night'
config.background = {
  {
    source = {
      File = "/Users/riley.gabrielson/lotr-background.jpeg",
    },
    height = "100%",
    attachment = "Fixed",
    repeat_x = "Mirror",
    horizontal_align = "Right"
  }
}
config.font = wezterm.font 'JetBrains Mono'

return config
