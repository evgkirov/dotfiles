return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local which_key = require("which-key")
        which_key.register(require("helpers.which-key-config"), { prefix = "<leader>" })
        which_key.register({ g = { p = { name = "󰧑 GPT" } } })
    end,
    opts = {
        icons = {
            breadcrumb = "",
            group = "",
        },
    },
}
