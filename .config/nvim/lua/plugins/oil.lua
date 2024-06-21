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
            ["<C-o>"] = function()
                local oil = require("oil")
                local dir = oil.get_current_dir()
                local entry = oil.get_cursor_entry()
                local filepath = dir .. entry.name
                local oil_window_id = vim.api.nvim_get_current_win()
                local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
                vim.api.nvim_set_current_win(picked_window_id)
                vim.cmd.edit(filepath)
                vim.api.nvim_set_current_win(oil_window_id)
                oil.close()
                vim.api.nvim_set_current_win(picked_window_id)
            end,
            ["<C-s>"] = false,
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
