local custom_oil_extension = {
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            function()
                local ok, oil = pcall(require, "oil")
                if ok then
                    return vim.fn.fnamemodify(oil.get_current_dir(), ":~")
                else
                    return ""
                end
            end,
        },
        lualine_x = {
            "branch",
        },
    },
    filetypes = { "oil" },
}

local custom_avante_extension = {
    sections = {},
    inactive_sections = {},
    filetypes = { "Avante", "AvanteInput", "AvanteSelectedFiles" },
}

-- local custom_avante_extension = {
--     sections = {
--         lualine_a = { "mode" },
--         lualine_x = { "filetype" },
--     },
--     inactive_sections = {
--         lualine_a = {},
--         lualine_x = { "filetype" },
--     },
--     filetypes = { "Avante", "AvanteInput", "AvanteSelectedFiles" },
-- }

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
            -- disabled_filetypes = {
            --     statusline = { "Avante", "AvanteInput", "AvanteSelectedFiles" },
            -- },
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
            custom_oil_extension,
            custom_avante_extension,
            -- "oil",
            "overseer",
            "quickfix",
            "toggleterm",
            "trouble",
        },
    },
}
