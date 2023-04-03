-- local colorscheme_light = "base16-tomorrow"
-- local colorscheme_dark = "base16-tomorrow-night"
local colorscheme_light = "gruvbox-material"
local colorscheme_dark = "gruvbox-material"

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

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "VertSplit", { link = "NvimTreeNormal" })
		vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { link = "VertSplit" })
	end,
})
