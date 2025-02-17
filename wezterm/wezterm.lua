-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = {}

-- Start maximized
-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function(cmd)
--     local _, _, window = mux.spawn_window(cmd or {})
--     window:gui_window():maximize()
-- end)

-- Padding around the window
config.window_padding = { left = 8, right = 8, top = 8, bottom = 0 }

-- Monokai Pro
-- local theme = wezterm.color.get_builtin_schemes()['Monokai Pro (Gogh)']
-- theme.background = "#2d2a2e"
-- config.colors = {
--     split = theme.ansi[6],
--     tab_bar = {
--         background = "#2d2a2e",
--         active_tab = {
--             bg_color = theme.ansi[6],
--             fg_color = theme.background,
--         },
--     }
-- }

-- config.color_schemes = {
--     ['My Theme'] = theme,
-- }
-- config.color_scheme = 'My Theme'

config.color_scheme = 'Tokyo Night Storm'

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16.0
config.line_height = 1.05

-- config.freetype_render_target = "HorizontalLcd"

config.enable_tab_bar = false
-- config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = true
-- config.enable_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = false

-- config.keys = {
--     { key = "m",  mods = "ALT", action = wezterm.action.TogglePaneZoomState },
--     { key = "c",  mods = "ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
--     { key = "n",  mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
--     { key = "p",  mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
--     { key = "x",  mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
--     { key = "w",  mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
--     { key = "-",  mods = "ALT", action = wezterm.action.SplitVertical },
--     { key = "\\", mods = "ALT", action = wezterm.action.SplitHorizontal },
--     { key = "h",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
--     { key = "l",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
--     { key = "k",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
--     { key = "j",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
--     { key = "r",  mods = "ALT", action = wezterm.action.RotatePanes("CounterClockwise") },
--     { key = "[",  mods = "ALT", action = wezterm.action.ActivateCopyMode },
--     {
--         key = "r",
--         mods = "ALT",
--         action = wezterm.action.PromptInputLine {
--             description = 'Enter new tab name',
--             action = wezterm.action_callback(function(window, _, line)
--                 if line then
--                     window:active_tab():set_title(line)
--                 end
--             end) },
--     }
-- }

-- and finally, return the configuration to wezterm
return config
