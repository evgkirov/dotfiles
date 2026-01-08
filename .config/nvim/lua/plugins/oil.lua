local function action_close_oil()
    local oil = require("oil")
    oil.save()
    oil.close()
end

return {
    "stevearc/oil.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = true,
    opts = {
        skip_confirm_for_simple_edits = true,
        keymaps = {
            ["q"] = action_close_oil,
            ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
            ["<C-v>"] = { "actions.select", opts = { vertical = true } },
            ["s"] = function()
                require("flash").jump({
                    jump = {
                        autojump = true,
                    },
                    action = function(match, state)
                        vim.api.nvim_win_call(match.win, function()
                            vim.api.nvim_win_set_cursor(match.win, match.pos)
                            require("oil").select()
                        end)
                    end,
                })
            end,
            ["S"] = function()
                require("flash").jump()
            end,
        },
        view_options = {
            show_hidden = true,
            sort = {
                { "name", "asc" }, -- should work macos-like
            },
        },
    },
    keys = {
        { "-", "<cmd>Oil<CR>", desc = "File explorer" },
        { "_", "<cmd>Oil .<CR>", desc = "File explorer from project root" },
    },
}
