return {
    "NvChad/nvim-colorizer.lua",
    enabled = not vim.g.is_quick_notes_mode,
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    opts = {
        filetypes = {
            "*",
        },
        options = {
            parsers = {
                hex = {
                    enable = true,
                    aarrggbb = true,
                },
            },
        },
    },
}
