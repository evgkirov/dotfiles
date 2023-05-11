local nvim_tree = require("nvim-tree")

nvim_tree.setup({
	sync_root_with_cwd = true,
	actions = {
		change_dir = {
			global = true,
		},
	},

	view = {
		width = 40,
	},
	update_focused_file = {
		enable = true,
	},
	renderer = {
		root_folder_label = false,
		icons = {
			git_placement = "after",
		},
	},
})

local function open_nvim_tree(data)
	-- open the tree, find the file but don't focus it
	require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
end

-- Screws up colorscheme
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
