local function action_close_oil()
    local oil = require("oil")
    oil.save()
    oil.close()
end

local function action_open_in_window(direction, select_target, float)
    return function()
        vim.cmd.write()
        local oil = require("oil")
        local dir = oil.get_current_dir()
        local entry = oil.get_cursor_entry()
        local filepath = dir .. entry.name
        local oil_window_id = vim.api.nvim_get_current_win()
        local file_window_id = require("helpers.opener").open_in_window(filepath, direction, select_target, float)
        vim.api.nvim_set_current_win(oil_window_id)
        oil.close()
        vim.api.nvim_set_current_win(file_window_id)
    end
end

return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = true,
    opts = {
        skip_confirm_for_simple_edits = true,
        keymaps = require("helpers.opener").create_mappings(action_open_in_window, {
            ["q"] = action_close_oil,
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
        }),
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
