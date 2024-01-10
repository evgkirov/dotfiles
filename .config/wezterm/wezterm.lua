-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Edge Light (base16)"
config.color_scheme = "Everforest Light (Gogh)"
config.font_size = 14.0
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.default_cwd = "/Users/evgkirov/Projects/"
-- config.font = wezterm.font 'FiraCode Nerd Font'
config.line_height = 1.01
config.cell_width = 0.9
config.freetype_load_target = "Light"
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
-- config.term = "wezterm"
-- config.default_cursor_style = "SteadyBar"
-- config.colors = {
--   cursor_bg = "#000000",
--   cursor_fg = "#FFFFFF",
--   cursor_border = "#000000",
-- }
function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Everforest Dark (Gogh)"
    else
        return "Everforest Light (Gogh)"
    end
end

-- Fixes unusable cursor color in neovim
local extra_colors_for_scheme = {
    ["Everforest Dark (Gogh)"] = {
        cursor_bg = "#9DA9A0",
        cursor_fg = "#2D353B",
        cursor_border = "#9DA9A0",
    },
    ["Everforest Light (Gogh)"] = {
        cursor_bg = "#5C6A72",
        cursor_fg = "#FDF6E3",
        cursor_border = "#5C6A72",
    },
}

wezterm.on("window-config-reloaded", function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    local scheme = scheme_for_appearance(appearance)
    if overrides.color_scheme ~= scheme then
        overrides.color_scheme = scheme
        overrides.colors = extra_colors_for_scheme[scheme]
        window:set_config_overrides(overrides)
    end
end)
-- and finally, return the configuration to wezterm
return config
