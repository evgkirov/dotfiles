vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
        version = vim.version.range("*"),
    },
    "https://github.com/nvim-treesitter/nvim-treesitter",
})

require("treesitter-context").setup({
    -- mode = "topline",
    mode = "cursor",
})
