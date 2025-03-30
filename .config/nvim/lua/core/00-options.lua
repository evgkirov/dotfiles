vim.o.relativenumber = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.title = true
vim.o.clipboard = "unnamedplus"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.textwidth = 0
vim.o.signcolumn = "auto:2"

vim.g.mapleader = " "

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.variables", "*.overrides" },
    command = "setfiletype less",
})

vim.api.nvim_create_autocmd("VimResized", {
    command = "tabdo wincmd =",
})

-- https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,globals,winsize,winpos,terminal,localoptions"
