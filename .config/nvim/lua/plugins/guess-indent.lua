return {
    "nmac427/guess-indent.nvim",
    enabled = not vim.g.is_quick_notes_mode,
    config = true,
    event = "BufReadPost",
}
