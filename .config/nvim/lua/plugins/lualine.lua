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
            function()
                local handle = io.popen(
                    "git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null"
                )
                if not handle then
                    return ""
                end
                local result = handle:read("*a")
                handle:close()
                result = result:gsub("%s+", "") -- remove any trailing newline or spaces
                return result
            end,
        },
    },
    filetypes = { "oil" },
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = true,
    opts = {
        --[[ options = {
            disabled_filetypes = { "NvimTree" },
            globalstatus = true,
        }, ]]
        options = {
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
        },
        -- options = { section_separators = "", component_separators = "" },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "filename", path = 4 } },
            lualine_c = { "diff", "diagnostics" },
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
            -- "oil",
            "overseer",
            "quickfix",
            "toggleterm",
            "trouble",
        },
    },
}
