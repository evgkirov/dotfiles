return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = true,
    opts = {
        --[[ options = {
            disabled_filetypes = { "NvimTree" },
            -- globalstatus = true,
        }, ]]
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { { "filename", path = 4 } },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
    },
}
