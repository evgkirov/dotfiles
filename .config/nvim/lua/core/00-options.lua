vim.o.relativenumber = true
vim.cmd("set number relativenumber")
vim.o.title = true
vim.o.clipboard = "unnamedplus"
vim.o.splitbelow = true
vim.o.splitright = true
-- vim.o.conceallevel = 1
-- vim.o.signcolumn = "auto:3"

vim.g.mapleader = " "
-- vim.o.fillchars = table.concat({ "eob:~", "vert:▏", "verthoriz:╬", "vertleft:▏", "vertright:▏" }, ",")
-- vim.o.fillchars = table.concat({ "eob: ", "vert:▏", "verthoriz:╬", "vertleft:▏", "vertright:▏" }, ",")

vim.cmd("autocmd BufNewFile,BufRead *.variables setfiletype less")
vim.cmd("autocmd BufNewFile,BufRead *.overrides setfiletype less")

-- auto resize windows when vim is resized
vim.cmd("autocmd VimResized * tabdo wincmd =")

-- https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,globals,winsize,winpos,terminal,localoptions"
