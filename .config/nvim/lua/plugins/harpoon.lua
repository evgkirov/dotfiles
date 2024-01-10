require("helpers.which-key-config").h = { name = "󰃀 Harpoon..." }

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
        },
    },
    keys = {
        {
            "<leader>hh",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Harpoon UI",
        },
        {
            "<leader>ha",
            function()
                local harpoon = require("harpoon")
                harpoon:list():append()
            end,
            desc = "Append to Harpoon list",
        },
        {
            "<leader>hi",
            function()
                local harpoon = require("harpoon")
                harpoon:list():prepend()
            end,
            desc = "Prepend to Harpoon list",
        },
        {
            "<leader>j",
            function()
                local harpoon = require("harpoon")
                harpoon:list():next()
            end,
            desc = "󰒭 Next in Harpoon list",
        },
        {
            "<leader>k",
            function()
                local harpoon = require("harpoon")
                harpoon:list():prev()
            end,
            desc = "󰒮 Previous in Harpoon list",
        },
        {
            "<leader>h1",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(1)
            end,
            desc = "Item 1",
        },
        {
            "<leader>h2",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(2)
            end,
            desc = "Item 2",
        },
        {
            "<leader>h3",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(3)
            end,
            desc = "Item 3",
        },
        {
            "<leader>h4",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(4)
            end,
            desc = "Item 4",
        },
        {
            "<leader>h5",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(5)
            end,
            desc = "Item 5",
        },
        {
            "<leader>h6",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(6)
            end,
            desc = "Item 6",
        },
        {
            "<leader>h7",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(7)
            end,
            desc = "Item 7",
        },
        {
            "<leader>h8",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(8)
            end,
            desc = "Item 8",
        },
        {
            "<leader>h9",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(9)
            end,
            desc = "Item 9",
        },
    },
}
