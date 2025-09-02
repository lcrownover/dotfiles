-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = {}

-- Start maximized
-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function(cmd)
--     local _, _, window = mux.spawn_window(cmd or {})
--     window:gui_window():maximize()
-- end)

config.window_decorations = "TITLE | RESIZE | MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR"
config.window_padding = { left = 8, right = 8, top = 8, bottom = 0 }
config.initial_rows = 38
config.initial_cols = 168
config.default_cwd = wezterm.home_dir

config.color_scheme = 'Tokyo Night Storm'

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16.0
config.line_height = 1.05

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

config.keys = {
  { key = "w", mods = "CMD",        action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  { key = "t", mods = "CMD",        action = wezterm.action({SpawnCommandInNewTab = { cwd = wezterm.home_dir }})},
  { key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },

  { key = "m", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },
  { key = "[", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCopyMode },

  { key = "n", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
  { key = "p", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

  { key = "_", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical },
  { key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal },

  -- temp until muscle memory
  { key = "h", mods = "CTRL|SHIFT",       action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL|SHIFT",       action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k", mods = "CTRL|SHIFT",       action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j", mods = "CTRL|SHIFT",       action = wezterm.action.ActivatePaneDirection("Down") },
  -- migrate muscle memory here
  { key = "h", mods = "CTRL",       action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL",       action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k", mods = "CTRL",       action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j", mods = "CTRL",       action = wezterm.action.ActivatePaneDirection("Down") },
  { key = " ", mods = "CTRL|SHIFT", action = wezterm.action.RotatePanes("CounterClockwise") },

  { key = "UpArrow",    mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ 'Up', 1 }) },
  { key = "DownArrow",  mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ 'Down', 1 }) },
  { key = "LeftArrow",  mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ 'Left', 1 }) },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ 'Right', 1 }) },

  { key = "5", mods = "CTRL|SHIFT", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },

  {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PromptInputLine {
      description = 'Enter new tab name',
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end) },
  }
}

return config
