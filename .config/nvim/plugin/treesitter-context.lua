vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", version = vim.version.range("*") },
})

require("treesitter-context").setup()
