-- set theme here
local current_theme_name = "edge"

local available_themes = {
    adwaita = {
        repo = "Mofiqul/adwaita.nvim",
        light = "adwaita",
        dark = "adwaita",
    },
    alabaster = {
        repo = "p00f/alabaster.nvim",
        light = "alabaster",
        dark = "alabaster",
    },
    catppuccin = { -- great
        repo = "catppuccin/nvim",
        light = "catppuccin-latte",
        dark = "catppuccin-macchiato",
    },
    edge = { -- great
        repo = "sainnhe/edge",
        light = "edge",
        dark = "edge",
    },
    everforest = { -- great
        repo = "sainnhe/everforest",
        light = "everforest",
        dark = "everforest",
    },
    fox = { -- good
        repo = "EdenEast/nightfox.nvim",
        light = "dawnfox",
        dark = "nightfox",
    },
    github = {
        repo = "projekt0n/github-nvim-theme",
        light = "github_light",
        dark = "github_dark",
    },
    gruvbox = { -- great
        repo = "sainnhe/gruvbox-material",
        light = "gruvbox-material",
        dark = "gruvbox-material",
    },
    one = {
        repo = "olimorris/onedarkpro.nvim",
        light = "onelight",
        dark = "onedark",
    },
    rosepine = { -- good?
        repo = "rose-pine/neovim",
        light = "rose-pine",
        dark = "rose-pine",
    },
    tokyonight = {
        repo = "folke/tokyonight.nvim",
        light = "tokyonight-day",
        dark = "tokyonight",
    },
    xcode = {
        repo = "arzg/vim-colors-xcode",
        light = "xcode",
        dark = "xcode",
    },
}

local current_theme = available_themes[current_theme_name]

local function set_light_mode()
    vim.api.nvim_set_option("background", "light")
    vim.cmd("colorscheme " .. current_theme.light)
end

local function set_dark_mode()
    vim.api.nvim_set_option("background", "dark")
    vim.cmd("colorscheme " .. current_theme.dark)
end

return {
    "f-person/auto-dark-mode.nvim",
    dependencies = {
        { current_theme.repo, name = "colorscheme-" .. current_theme_name },
    },
    lazy = false,
    priority = 1000,
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
