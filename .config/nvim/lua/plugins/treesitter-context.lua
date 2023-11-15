return {
    "nvim-treesitter/nvim-treesitter-context",
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
