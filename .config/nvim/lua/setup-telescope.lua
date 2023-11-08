local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["jk"] = actions.close,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			file_ignore_patterns = { "node_modules" },
		},
	},
	extensions = {},
})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- vim.keymap.set("n", "<Tab>", builtin.buffers, {})
vim.keymap.set("n", "<Tab>", ":Telescope buffers sort_lastused=true<CR>", {})
-- vim.keymap.set("n", "<Tab>", ":Telescope frecency<CR>", {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set("n", "<leader>fS", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
