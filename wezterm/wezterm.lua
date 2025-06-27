-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font = wezterm.font("CaskaydiaCove Nerd Font")
  config.font_size = 10
  config.default_domain = "WSL:Arch"
  config.window_background_opacity = 0.95
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
else
  config.font = wezterm.font("CaskaydiaCove Nerd Font Mono")
  config.font_size = 13
end

config.automatically_reload_config = true
config.color_scheme = "GruvboxDark"
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 150,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 150,
  target = "CursorColor",
}
config.colors = {
  visual_bell = "#ff2020",
}

-- and finally, return the configuration to wezterm
return config
