local disable_autoformat_status = {
    function()
        if vim.g.disable_autoformat or vim.b.disable_autoformat then
            return "Autoformat: OFF"
        else
            return ""
        end
    end,
    color = "lualine_c_diagnostics_error_normal",
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = true,
    opts = {
        options = {
            section_separators = "",
            component_separators = "",
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "filename", path = 4 } },
            lualine_c = { "diff", "diagnostics", disable_autoformat_status },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        extensions = {
            "aerial",
            "lazy",
            "mason",
            "overseer",
            "quickfix",
            "toggleterm",
            "trouble",
        },
    },
}
