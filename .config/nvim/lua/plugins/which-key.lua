return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").register(require("helpers.which-key-config"), { prefix = "<leader>" })
    end,
    opts = {
        icons = {
            breadcrumb = "",
            group = "",
        },
    },
}
