return {
    "nvim-treesitter/nvim-treesitter-context",
    version = "*",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    event = "BufEnter",
    config = true,
    opts = {
        -- mode = "topline",
        mode = "cursor",
    },
}
