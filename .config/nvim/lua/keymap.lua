local keymap = vim.keymap.set
local opts = { silent = true }

-- keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprev<CR>", opts)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", ";", ":", {})
keymap("n", "!", ":! ", {})
keymap("i", "<Enter>", "<CR>", opts)
