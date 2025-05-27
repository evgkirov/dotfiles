return {
    "m4xshen/hardtime.nvim",
    version = "*",
    lazy = false,
    -- enabled = false,
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            version = "*",
            init = function()
                vim.notify = require("notify")
            end,
            opts = {
                fps = 60,
                render = "wrapped-default",
                stages = "slide",
            },
        },
    },
    opts = {
        disable_mouse = false,
    },
}
