return {
    "leath-dub/snipe.nvim",
    config = true,
    opts = {},
    keys = {
        {
            "<leader><space>",
            function()
                local toggle = require("snipe").create_buffer_menu_toggler()
                toggle()
            end,
            desc = "Toggle Snipe buffer",
        },
    },
}
