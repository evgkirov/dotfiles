return {
    "dnlhc/glance.nvim",
    config = function()
        local glance = require("glance")
        local actions = glance.actions

        glance.setup({
            -- detached = true,
            -- border = { enable = true },
            -- list = { position = "left" },
            mappings = {
                list = {
                    -- ["<F7>"] = actions.enter_win("preview"),
                    ["<space>"] = actions.enter_win("preview"),
                    ["<C-h>"] = actions.jump_split,
                    ["<C-v>"] = actions.jump_vsplit,
                    ["<C-t>"] = actions.jump_tab,
                    ["s"] = false,
                    ["v"] = false,
                    ["t"] = false,
                    ["<C-o>"] = function()
                        local picked_window_id = require("window-picker").pick_window()
                            or vim.api.nvim_get_current_win()
                        actions.jump_vsplit()
                        local new_window_id = vim.api.nvim_get_current_win()
                        local new_buffer_id = vim.api.nvim_get_current_buf()
                        local new_position = vim.api.nvim_win_get_cursor(new_window_id)
                        vim.cmd.close()
                        vim.api.nvim_set_current_win(picked_window_id)
                        vim.api.nvim_set_current_buf(new_buffer_id)
                        vim.api.nvim_win_set_cursor(picked_window_id, new_position)
                        -- print(glance:list:get_current_item())
                    end,
                },
                preview = {
                    -- ["<F10>"] = actions.enter_win("list"),
                    ["<space>"] = actions.enter_win("list"),
                },
            },
        })
    end,
    keys = {
        { "gd", "<cmd>Glance definitions<CR>", desc = "Show definition" },
        { "gr", "<cmd>Glance references<CR>", desc = "Show references" },
    },
}
