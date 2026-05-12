local wezterm = require 'wezterm';

local config = wezterm.config_builder()


-- Slightly transparent and blurred background
config.window_background_opacity = 0.95
config.macos_window_background_blur = 30
-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = 'INTEGRATED_BUTTONS'
-- Sets the font for the window frame (tab bar)
config.window_frame = {
  -- Berkeley Mono for me again, though an idea could be to try a
  -- serif font here instead of monospace for a nicer look?
  font = wezterm.font({ family = 'Berkeley Mono', weight = 'Bold' }),
  font_size = 11,
}


config.font_size = 14.5
config.color_scheme = 'Adventure Time (Gogh)'
--config.colors.copy_mode_active_highlight_bg = { Color = '#000000' }
--config.colors.copy_mode_active_highlight_fg = { AnsiColor = 'Black' }
--config.colors.copy_mode_inactive_highlight_bg = { Color = '#52ad70' }
--config.colors.copy_mode_inactive_highlight_fg = { AnsiColor = 'White' }

config.mouse_bindings = {
  -- Обычное выделение левой кнопкой
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.SelectTextAtMouseCursor 'Cell',
  },
  -- Отключить drag окна при случайном захвате края
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'SUPER',
    action = wezterm.action.StartWindowDrag,
  },
}

config.keys = {
    {
      key = 'P',
      mods = 'CMD|SHIFT',
      action = wezterm.action.ActivateCommandPalette,
    },
    {
      key = ',',
      mods = 'SUPER',
      action = wezterm.action.SpawnCommandInNewTab {
        cwd = wezterm.home_dir,
        args = { 'vim', wezterm.config_file },
      },
    },
    {
      key = '%',
      mods = 'SUPER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '"',
      mods = 'SUPER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
--    {
--      key = 'a',
--      -- When we're in leader mode _and_ CTRL + A is pressed...
--      mods = 'LEADER|CTRL',
--    -- Actually send CTRL + A key to the terminal
--      action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
--    },
    {
      key = "[",
      mods = 'SUPER',
      action = wezterm.action.ActivateCopyMode,
    },
    {
      key = 'LeftArrow',
      mods = 'SUPER',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'RightArrow',
      mods = 'SUPER',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
      key = 'UpArrow',
      mods = 'SUPER',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      mods = 'SUPER',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
  }

return config
