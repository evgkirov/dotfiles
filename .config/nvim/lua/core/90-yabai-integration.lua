vim.keymap.set({ "n", "t", "v", "i" }, "<F7>", function()
    local oldnr = vim.fn.winnr()
    vim.cmd("wincmd h")
    if oldnr == vim.fn.winnr() then
        os.execute("yabai -m window --focus west")
    end
end, { desc = "Focus 󰁍" })

vim.keymap.set({ "n", "t", "v", "i" }, "<F8>", function()
    local oldnr = vim.fn.winnr()
    vim.cmd("wincmd j")
    if oldnr == vim.fn.winnr() then
        os.execute("yabai -m window --focus south")
    end
end, { desc = "Focus 󰁅" })

vim.keymap.set({ "n", "t", "v", "i" }, "<F9>", function()
    local oldnr = vim.fn.winnr()
    vim.cmd("wincmd k")
    if oldnr == vim.fn.winnr() then
        os.execute("yabai -m window --focus north")
    end
end, { desc = "Focus 󰁝" })

vim.keymap.set({ "n", "t", "v", "i" }, "<F10>", function()
    local oldnr = vim.fn.winnr()
    vim.cmd("wincmd l")
    if oldnr == vim.fn.winnr() then
        os.execute("yabai -m window --focus east")
    end
end, { desc = "Focus 󰁔" })
