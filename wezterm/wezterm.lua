-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Start maximized
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- Don't show the tab bar
config.hide_tab_bar_if_only_one_tab = true

-- Don't prompt to exit
config.window_close_confirmation = "NeverPrompt"

-- Padding around the window
config.window_padding = { left = 8, right = 8, top = 8, bottom = 0 }

-- Color settings
-- config.color_scheme = "Everforest Dark (Gogh)"
-- config.color_scheme = "Catppuccin Macchiato"
config.color_scheme = "Monokai Pro (Gogh)"

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })
config.font_size = 16.0
config.line_height = 1.05

config.freetype_render_target = "HorizontalLcd"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

config.keys = {
    { key = "m",  mods = "ALT", action = wezterm.action.TogglePaneZoomState },
    { key = "c",  mods = "ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "n",  mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
    { key = "p",  mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "x",  mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
    { key = "w",  mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
    { key = "-",  mods = "ALT", action = wezterm.action.SplitVertical },
    { key = "\\", mods = "ALT", action = wezterm.action.SplitHorizontal },
    { key = "h",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "l",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "k",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "j",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "r",  mods = "ALT", action = wezterm.action.RotatePanes("CounterClockwise") },
    { key = "[",  mods = "ALT", action = wezterm.action.ActivateCopyMode },
}

-- and finally, return the configuration to wezterm
return config
