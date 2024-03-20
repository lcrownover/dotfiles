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
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }

-- Color settings
config.color_scheme = "Gruvbox Material (Gogh)"

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = 'Medium' })
config.font_size = 16.0
config.line_height = 1.05

config.freetype_render_target = "HorizontalLcd"

-- and finally, return the configuration to wezterm
return config
