vim.pack.add({
    "https://github.com/sainnhe/everforest",
    "https://github.com/f-person/auto-dark-mode.nvim",
})

vim.g.everforest_background = "medium"
vim.cmd("colorscheme everforest")
require("auto-dark-mode").setup()
