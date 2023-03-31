require("bufferline").setup({
	options = {
		-- separator_style = "padded_slant",
		offsets = {
			{
				filetype = "NvimTree",
				text = function()
					return string.match(vim.fn.getcwd(), ".+/([^/]+)$")
				end,
				-- highlight = "Directory",
				separator = " ",
			},
		},
	},
})
