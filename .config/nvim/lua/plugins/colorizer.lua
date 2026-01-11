return {
    "NvChad/nvim-colorizer.lua",
    enabled = not vim.g.is_quick_notes_mode,
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    opts = {
        user_default_options = {
            -- RRGGBBAA = true,
            AARRGGBB = true,
            names = false,
        },
        filetypes = {
            "*",
        },
    },
}
