return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        label = {
            uppercase = false,
            rainbow = {
                enabled = true,
                shade = 9,
            },
        },
        modes = {
            char = {
                enabled = false,
            },
        },
    },
    keys = {
        {
            "s",
            mode = { "n" },
            function()
                require("flash").jump()
            end,
            desc = "Flash Go",
        },
        {
            "s",
            mode = { "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Select",
        },
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
                require("flash").treesitter()
            end,
            desc = "Flash Go+Select",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
        {
            "R",
            mode = { "o", "x" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "Treesitter Search",
        },
        {
            "<c-s>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash Search",
        },
    },
}
