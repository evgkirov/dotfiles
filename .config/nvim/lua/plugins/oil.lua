return {
    "stevearc/oil.nvim",
    opts = {
        keymaps = {
            ["-"] = false,
        },
        view_options = {
            show_hidden = true,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        -- { "-", ":Oil<CR>" },
        {
            "-",
            function()
                require("oil").toggle_float()
            end,
        },
    },
}
