local wezterm = require 'wezterm';

local config = wezterm.config_builder()

config.font_size = 14.5
config.color_scheme = 'Afterglow'
config.keys = {
    {
      key = 'P',
      mods = 'CMD|SHIFT',
      action = wezterm.action.ActivateCommandPalette,
    },
  }

return config