require("helpers.which-key-config").c = { name = "󰅩 Code..." }

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            bash = { "shfmt" },
            css = { "prettier" },
            graphql = { "prettier" },
            html = { "prettier" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "isort", "black" },
            sh = { "shfmt" },
            svelte = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            yaml = { "prettier" },
        },
    },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            desc = "Format",
        },
    },
}
