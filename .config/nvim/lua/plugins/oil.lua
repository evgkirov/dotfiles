return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = true,
    opts = {
        -- skip_confirm_for_simple_edits = true,
        keymaps = {
            ["<leader>x"] = "actions.close",
            ["q"] = "actions.close",
            ["<C-h>"] = function()
                local oil = require("oil")
                oil.select({ horizontal = true })
                oil.close()
            end,
            ["<C-v>"] = function()
                local oil = require("oil")
                oil.select({ vertical = true })
                oil.close()
            end,
        },
        view_options = {
            show_hidden = true,
        },
        sort = {
            { "name", "asc" }, -- should work macos-like
        },
    },
    keys = {
        { "-", "<cmd>Oil<CR>", desc = "File explorer" },
        { "_", "<cmd>Oil .<CR>", desc = "File explorer from project root" },
    },
}
