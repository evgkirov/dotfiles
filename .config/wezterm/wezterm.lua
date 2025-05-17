local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.default_cwd = "/Users/evgkirov/Obsidian/Personal"
config.default_prog = { "/opt/homebrew/bin/fish", "-c", "NEOVIM_MODE=quick_notes nvim" }

local function get_current_theme_config()
    local themes_dir = wezterm.home_dir .. "/.config/themes/"
    local f = io.open(themes_dir .. "current")
    local current_theme_name = f:read()
    f:close()
    local current_theme = loadfile(themes_dir .. current_theme_name .. "/wezterm.lua")
    return current_theme()
end

config.font = wezterm.font_with_fallback({
    -- "TX-02",
    -- "Iosevka Custom",
    -- "Iosevka Term",
    -- "Iosevka Term SS05",
    -- "Iosevka Term SS08",
    -- "Iosevka Term SS09",
    -- "Iosevka Term SS14",
    -- "Iosevka Term SS18",
    -- "VictorMono NFM Medium",
    "JetBrainsMono Nerd Font",
    "Symbols Nerd Font Mono",
    "Apple Color Emoji",
})

config.font_size = 12.0

-- config.freetype_load_flags = "NO_HINTING"

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "TITLE|MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR|RESIZE"
config.use_resize_increments = true
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
