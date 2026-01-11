local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.default_cwd = wezterm.home_dir .. "/Obsidian/Personal"
config.default_prog = { "/opt/homebrew/bin/fish", "-c", "NEOVIM_MODE=quick_notes nvim" }

config.font = wezterm.font_with_fallback({
    "PragmataPro Liga",
    "JetBrainsMono Nerd Font Mono",
    "Symbols Nerd Font Mono",
    "Apple Color Emoji",
})

config.font_size = 13.0

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "TITLE|MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR|RESIZE"
config.use_resize_increments = true
-- config.window_padding = {
--     left = 0,
--     right = 0,
--     top = 0,
--     bottom = 0,
-- }

local function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Everforest Dark (Gogh)"
    else
        return "Everforest Light (Gogh)"
    end
end

wezterm.on("window-config-reloaded", function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    local scheme = scheme_for_appearance(appearance)
    if overrides.color_scheme ~= scheme then
        overrides.color_scheme = scheme
        window:set_config_overrides(overrides)
    end
end)

return config
