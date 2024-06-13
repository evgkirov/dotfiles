local function close_oil()
    local oil = require("oil")
    oil.save()
    oil.close()
end

return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = true,
    opts = {
        -- skip_confirm_for_simple_edits = true,
        keymaps = {
            ["<leader>x"] = close_oil,
            ["q"] = close_oil,
            ["<C-h>"] = { "actions.select", opts = { horizontal = true, close = true } },
            ["<C-v>"] = { "actions.select", opts = { vertical = true, close = true } },
            ["<C-s>"] = false,
        },
        view_options = {
            show_hidden = true,
            --[[ sort = {
                { "name", "asc" }, -- should work macos-like
            }, ]]
        },
    },
    keys = {
        { "-", "<cmd>Oil<CR>", desc = "File explorer" },
        { "_", "<cmd>Oil .<CR>", desc = "File explorer from project root" },
    },
}
