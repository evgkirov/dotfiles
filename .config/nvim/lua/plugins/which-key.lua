return {
    "folke/which-key.nvim",
    version = "*",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local which_key = require("which-key")
        which_key.add({
            { "<leader>a", group = "󰧑 AI..." },
            { "<leader>c", group = "󰅩 Code..." },
            { "<leader>d", group = "󰡨 Docker..." },
            { "<leader>f", group = "󰍉 Find..." },
            { "<leader>g", group = "󰊢 Git..." },
            { "<leader>m", group = "󰍔 Markdown..." },
            { "<leader>n", group = " Terminal..." },
            { "<leader>r", group = "󱤵 Run..." },
            { "<leader>t", group = "󰓩 Tabs..." },
        })
    end,
    opts = {
        icons = {
            breadcrumb = "",
            group = "",
            rules = false,
        },
        disable = {
            ft = { "toggleterm" },
        },
    },
}
