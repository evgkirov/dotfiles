return {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    opts = {
        user_default_options = {
            -- RRGGBBAA = true,
            AARRGGBB = true,
            names = false,
        },
    },
}
