local selected_abbr = "edge" -- change it

local available_colorschemes = {
	adwaita = { "adwaita", "adwaita" },
	alabaster = { "alabaster", "alabaster" },
	catppuccin = { "catppuccin-latte", "catppuccin-macchiato" }, -- !!!
	edge = { "edge", "edge" }, -- !!!
	fox = { "dawnfox", "nightfox" },
	github = { "github_light", "github_dark" },
	gruvbox = { "gruvbox-material", "gruvbox-material" }, -- !!!
	one = { "onelight", "onedark" },
	rosepine = { "rose-pine", "rose-pine" },
	xcode = { "xcode", "xcode" },
	everforest = { "everforest", "everforest" },
}

local selected_pair = available_colorschemes[selected_abbr]
local colorscheme_light = selected_pair[1]
local colorscheme_dark = selected_pair[2]

vim.o.termguicolors = true
vim.g.gruvbox_material_background = "medium"
vim.g.everforest_background = "hard"
vim.cmd("colorscheme " .. colorscheme_light)

local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
	set_dark_mode = function()
		vim.api.nvim_set_option("background", "dark")
		vim.cmd("colorscheme " .. colorscheme_dark)
	end,
	set_light_mode = function()
		vim.api.nvim_set_option("background", "light")
		vim.cmd("colorscheme " .. colorscheme_light)
	end,
})
auto_dark_mode.init()
