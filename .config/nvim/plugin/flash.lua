vim.pack.add({
    "https://github.com/folke/flash.nvim",
})

require("flash").setup({
    label = {
        uppercase = false,
        rainbow = {
            enabled = true,
            shade = 9,
        },
    },
    modes = {
        char = { enabled = false },
    },
})

vim.keymap.set("n", "s", function()
    require("flash").jump()
end, { desc = "Flash Go" })

vim.keymap.set({ "x", "o" }, "s", function()
    require("flash").treesitter()
end, { desc = "Flash Select" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
    require("flash").jump()
    require("flash").treesitter()
end, { desc = "Flash Go+Select" })

vim.keymap.set("o", "r", function()
    require("flash").remote()
end, { desc = "Remote Flash" })

vim.keymap.set({ "o", "x" }, "R", function()
    require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

vim.keymap.set("c", "<c-s>", function()
    require("flash").toggle()
end, { desc = "Toggle Flash Search" })
