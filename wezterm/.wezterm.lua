local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'JetBrains Mono'
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
config.background = {
  {
    source = {
      Color = "black",
    },
    width = "100%",
    height = "100%",
    attachment = "Fixed",
    opacity = 0.1,
  }
}

return config
