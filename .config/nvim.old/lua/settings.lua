-- for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.termguicolors = true

-- personal preferences
vim.o.relativenumber = true
vim.cmd("set number relativenumber")
vim.o.title = true
vim.o.clipboard = "unnamedplus"
--vim.o.fillchars = "eob: ,vert: "
--vim.o.fillchars = "eob: ,vert:▏"
-- vim.o.fillchars = table.concat(
--   { 'eob: ', 'fold:╌', 'horiz:═', 'horizdown:╦', 'horizup:╩', 'vert:║', 'verthoriz:╬', 'vertleft:╣', 'vertright:╠' },
--   ','
-- )
vim.o.fillchars = table.concat({ "eob: ", "vert:▏", "verthoriz:╬", "vertleft:▏", "vertright:▏" }, ",")
