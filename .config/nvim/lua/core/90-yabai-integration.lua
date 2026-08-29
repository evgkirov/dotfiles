local function switch_window(nvim_direction, tmux_direction, yabai_direction)
    return function()
        local fallback = "yabai -m window --focus " .. yabai_direction .. " > /dev/null 2>&1"
        if yabai_direction == "west" then
            fallback = fallback .. " || yabai -m display --focus 2"
        elseif yabai_direction == "east" then
            fallback = fallback .. " || yabai -m display --focus 1"
        end
        if vim.env.TMUX then
            fallback = "sh ~/.config/yabai/navigate.sh " .. tmux_direction .. " > /dev/null 2>&1"
        end
        local oldnr = vim.fn.winnr()
        if vim.api.nvim_win_get_config(0).zindex then
            -- Ignore floating windows
            os.execute(fallback)
            return
        end
        vim.cmd.wincmd(nvim_direction)
        if oldnr == vim.fn.winnr() then
            os.execute(fallback)
        end
    end
end

vim.keymap.set({ "n", "t", "v", "i" }, "<F7>", switch_window("h", "left", "west"), { desc = "Focus 󰁍" })
vim.keymap.set({ "n", "t", "v", "i" }, "<F8>", switch_window("j", "down", "south"), { desc = "Focus 󰁅" })
vim.keymap.set({ "n", "t", "v", "i" }, "<F9>", switch_window("k", "up", "north"), { desc = "Focus 󰁝" })
vim.keymap.set({ "n", "t", "v", "i" }, "<F10>", switch_window("l", "right", "east"), { desc = "Focus 󰁔" })
