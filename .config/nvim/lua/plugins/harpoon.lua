require("helpers.which-key-config")[" "] = { name = "󰃀 Harpoon..." }

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
    --[[ keys = {
        {
            "<leader><space>",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Harpoon UI",
        },
        {
            "<leader>=",
            function()
                local harpoon = require("harpoon")
                harpoon:list():add()
            end,
            desc = "Append to Harpoon list",
        },
        {
            "<leader>+",
            function()
                local harpoon = require("harpoon")
                harpoon:list():prepend()
            end,
            desc = "Prepend to Harpoon list",
        },
        {
            "<leader>1",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(1)
            end,
            desc = "Harpoon: Item 1",
        },
        {
            "<leader>2",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(2)
            end,
            desc = "Harpoon: Item 2",
        },
        {
            "<leader>3",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(3)
            end,
            desc = "Harpoon: Item 3",
        },
        {
            "<leader>4",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(4)
            end,
            desc = "Harpoon: Item 4",
        },
        {
            "<leader>5",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(5)
            end,
            desc = "Harpoon: Item 5",
        },
        {
            "<leader>6",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(6)
            end,
            desc = "Harpoon: Item 6",
        },
        {
            "<leader>7",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(7)
            end,
            desc = "Harpoon: Item 7",
        },
        {
            "<leader>8",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(8)
            end,
            desc = "Harpoon: Item 8",
        },
        {
            "<leader>9",
            function()
                local harpoon = require("harpoon")
                harpoon:list():select(9)
            end,
            desc = "Harpoon: Item 9",
        },
    },
    ]]
}
