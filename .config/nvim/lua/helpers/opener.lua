local M = {}

--- @param filepath? string
--- @param direction? string
--- | "left"
--- | "bottom"
--- | "top"
--- | "right"
--- @param select_target? boolean
--- @return number
function M.open_in_window(filepath, direction, select_target, float)
    if float then
        local ui = vim.api.nvim_list_uis()[1]

        local opened_window_id = vim.api.nvim_open_win(0, true, {
            relative = "editor",
            width = math.ceil(ui.width * 0.8),
            height = math.ceil(ui.height * 0.8),
            col = math.ceil(ui.width * 0.1),
            row = math.ceil(ui.height * 0.1),
            border = "single",
        })
        vim.api.nvim_set_current_win(opened_window_id)
    else
        if select_target then
            local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
            vim.api.nvim_set_current_win(picked_window_id)
        end

        if direction == "top" then
            vim.cmd("leftabove split")
        elseif direction == "right" then
            vim.cmd("rightbelow vsplit")
        elseif direction == "bottom" then
            vim.cmd("rightbelow split")
        elseif direction == "left" then
            vim.cmd("leftabove vsplit")
        end

        vim.cmd.wincmd("=")
    end

    if filepath ~= nil then
        vim.cmd.edit(filepath)
    end
    return vim.api.nvim_get_current_win()
end

--- @param action_func function
--- @param other_keymap? table
--- @return table
function M.create_mappings(action_func, other_keymap)
    local mappings = {
        ["<C-f>"] = action_func(nil, nil, true),
        ["<C-h>"] = action_func("left"),
        ["<C-j>"] = action_func("bottom"),
        ["<C-k>"] = action_func("top"),
        ["<C-l>"] = action_func("right"),
        ["<C-o>"] = function() end,
        ["<C-o><C-o>"] = action_func(nil, true),
        ["<C-o><C-h>"] = action_func("left", true),
        ["<C-o><C-j>"] = action_func("bottom", true),
        ["<C-o><C-k>"] = action_func("top", true),
        ["<C-o><C-l>"] = action_func("right", true),
        ["<C-o>o"] = action_func(nil, true),
        ["<C-o>h"] = action_func("left", true),
        ["<C-o>j"] = action_func("bottom", true),
        ["<C-o>k"] = action_func("top", true),
        ["<C-o>l"] = action_func("right", true),
    }

    if other_keymap then
        for k, v in pairs(other_keymap) do
            mappings[k] = v
        end
    end

    return mappings
end

return M
