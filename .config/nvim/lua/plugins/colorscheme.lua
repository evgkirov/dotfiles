-- set theme here

local function get_current_theme_config()
    local themes_dir = vim.fn.expand("$HOME/.config/themes/")
    local fallback_theme = {
        repo = "sainnhe/everforest",
        light = "everforest",
        dark = "everforest",
    }
    local f = io.open(themes_dir .. "current")
    if f == nil then
        return fallback_theme
    end
    local current_theme_name = f:read()
    f:close()
    local current_theme = loadfile(themes_dir .. current_theme_name .. "/neovim.lua")
    if current_theme == nil then
        return fallback_theme
    end
    return current_theme()
end

local theme_config = get_current_theme_config()

local function overrides()
    vim.api.nvim_set_hl(0, "OverseerTaskBorder", { link = "VertSplit" })
end

local function set_light_mode()
    vim.o.background = "light"
    vim.cmd('let ayucolor="light"')
    vim.cmd("colorscheme " .. theme_config.light)
    overrides()
end

local function set_dark_mode()
    vim.o.background = "dark"
    vim.cmd('let ayucolor="dark"')
    vim.cmd("colorscheme " .. theme_config.dark)
    overrides()
end

return {
    "f-person/auto-dark-mode.nvim",
    dependencies = {
        theme_config.repo,
    },
    lazy = false,
    config = function()
        local auto_dark_mode = require("auto-dark-mode")
        vim.o.termguicolors = true
        vim.g.gruvbox_material_background = "medium"
        vim.g.everforest_background = "hard"
        set_light_mode()
        auto_dark_mode.setup({
            set_dark_mode = set_dark_mode,
            set_light_mode = set_light_mode,
        })
        auto_dark_mode.init()
    end,
}
