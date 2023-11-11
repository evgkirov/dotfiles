vim.keymap.set({ "n", "t", "v", "i" }, "<C-h>", function()
    local oldnr = vim.fn.winnr()
    vim.cmd("wincmd h")
    if oldnr == vim.fn.winnr() then
        os.execute("yabai -m window --focus west")
    end
end, { desc = "Focus 󰁍" })

vim.keymap.set({ "n", "t", "v", "i" }, "<C-j>", function()
    local oldnr = vim.fn.winnr()
    vim.cmd("wincmd j")
    if oldnr == vim.fn.winnr() then
        os.execute("yabai -m window --focus south")
    end
end, { desc = "Focus 󰁅" })

vim.keymap.set({ "n", "t", "v", "i" }, "<C-k>", function()
    local oldnr = vim.fn.winnr()
    vim.cmd("wincmd k")
    if oldnr == vim.fn.winnr() then
        os.execute("yabai -m window --focus north")
    end
end, { desc = "Focus 󰁝" })

vim.keymap.set({ "n", "t", "v", "i" }, "<C-l>", function()
    local oldnr = vim.fn.winnr()
    vim.cmd("wincmd l")
    if oldnr == vim.fn.winnr() then
        os.execute("yabai -m window --focus east")
    end
end, { desc = "Focus 󰁔" })
