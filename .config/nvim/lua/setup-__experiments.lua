require("lualine").setup({
	options = {
		theme = "gruvbox-material",
		globalstatus = false,
		disabled_filetypes = { "NvimTree" },
		--section_separators = '', component_separators = ''
	},
})

require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		untracked = { text = "" },
	},
})

local function close_nvim_tree()
	--	vim.cmd("NvimTreeClose")
	require("nvim-tree.api").tree.close()
end

local function open_nvim_tree()
	require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
end
require("auto-session").setup({
	log_level = "error",
	pre_save_cmds = { close_nvim_tree },
	post_save_cmds = { open_nvim_tree },
	post_open_cmds = { open_nvim_tree },
	post_restore_cmds = { open_nvim_tree },
	cwd_change_handling = {
		restore_upcoming_session = true, -- <-- THE DOCS LIE!! This is necessary!!
	},
})
require("bufdel").setup()

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = "all",
})
vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx" })

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- WTF??
-- vim.o.nofoldenable = true
-- vim.cmd("nofoldenable")
vim.o.foldlevel = 99
