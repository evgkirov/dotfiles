vim.o.relativenumber = true
vim.cmd("set number relativenumber")
vim.o.title = true
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.o.fillchars = table.concat({ "eob: ", "vert:▏", "verthoriz:╬", "vertleft:▏", "vertright:▏" }, ",")

vim.cmd("autocmd BufNewFile,BufRead *.variables setfiletype less")
vim.cmd("autocmd BufNewFile,BufRead *.overrides setfiletype less")
