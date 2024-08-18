local function switch_window(nvim_direction, yabai_direction)
    return function()
        local yabai_command = "yabai -m window --focus " .. yabai_direction .. " > /dev/null 2>&1"
        if yabai_direction == "west" then
            yabai_command = yabai_command .. " || yabai -m display --focus 2"
        elseif yabai_direction == "east" then
            yabai_command = yabai_command .. " || yabai -m display --focus 1"
        end
        local oldnr = vim.fn.winnr()
        if vim.api.nvim_win_get_config(0).zindex then
            -- Ignore floating windows
            os.execute(yabai_command)
            return
        end
        vim.cmd.wincmd(nvim_direction)
        if oldnr == vim.fn.winnr() then
            os.execute(yabai_command)
        end
    end
end

vim.keymap.set({ "n", "t", "v", "i" }, "<F7>", switch_window("h", "west"), { desc = "Focus 󰁍" })
vim.keymap.set({ "n", "t", "v", "i" }, "<F8>", switch_window("j", "south"), { desc = "Focus 󰁅" })
vim.keymap.set({ "n", "t", "v", "i" }, "<F9>", switch_window("k", "north"), { desc = "Focus 󰁝" })
vim.keymap.set({ "n", "t", "v", "i" }, "<F10>", switch_window("l", "east"), { desc = "Focus 󰁔" })
