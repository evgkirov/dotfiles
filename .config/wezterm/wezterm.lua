local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.automatically_reload_config = true
-- config.default_cwd = "/Users/evgkirov/Projects/"

local function get_current_theme_config()
    local themes_dir = wezterm.home_dir .. "/.config/themes/"
    local fallback_theme = {
        light = {
            name = "Everforest Light (Gogh)",
            overrides = {
                colors = {
                    cursor_bg = "#5C6A72",
                    cursor_fg = "#FDF6E3",
                    cursor_border = "#5C6A72",
                },
            },
        },
        dark = {
            name = "Everforest Dark (Gogh)",
            overrides = {
                colors = {
                    cursor_bg = "#9DA9A0",
                    cursor_fg = "#2D353B",
                    cursor_border = "#9DA9A0",
                },
            },
        },
    }
    local f = io.open(themes_dir .. "current")
    if f == nil then
        return fallback_theme
    end
    local current_theme_name = f:read()
    f:close()
    local current_theme = loadfile(themes_dir .. current_theme_name .. "/wezterm.lua")
    if current_theme == nil then
        return fallback_theme
    end
    return current_theme()
end

-- my old default
-- config.font_size = 14.0

-- might work for Dell 2880x....
-- config.font_size = 13.0

-- might work for Dell 2560x....
config.font_size = 12.0

config.font = wezterm.font({
    family = "JetBrainsMono Nerd Font",
    stretch = "ExtraExpanded",
    weight = "Regular",
})
-- config.line_height = 1.01
-- config.cell_width = 0.9
-- config.freetype_load_target = "Light"
-- config.freetype_load_flags = "FORCE_AUTOHINT"

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

wezterm.on("window-config-reloaded", function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    local theme_config = get_current_theme_config()
    local new_theme = theme_config.light
    if appearance:find("Dark") then
        new_theme = theme_config.dark
    end
    if overrides.color_scheme ~= new_theme.name then
        overrides.color_scheme = new_theme.name
        if new_theme.overrides == nil then
            overrides.colors = nil
        else
            overrides.colors = new_theme.overrides.colors
        end
        window:set_config_overrides(overrides)
    end
end)

return config
