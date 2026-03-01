return {
    "NvChad/nvim-colorizer.lua",
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
