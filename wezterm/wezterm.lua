-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'GruvboxDark'
config.font = wezterm.font('CaskaydiaCove Nerd Font Mono')
config.font_size = 13
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
  target = 'CursorColor',
}
config.colors = {
  visual_bell = '#ff2020',
}

-- and finally, return the configuration to wezterm
return config
