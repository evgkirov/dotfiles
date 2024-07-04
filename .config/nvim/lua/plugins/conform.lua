require("helpers.which-key-config").c = { name = "󰅩 Code..." }

return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
        formatters_by_ft = {
            bash = { "shfmt" },
            css = { "prettierd" },
            graphql = { "prettierd" },
            html = { "prettierd" },
            javascript = { "prettierd", "eslint_d" },
            javascriptreact = { "prettierd", "eslint_d" },
            json = { "prettierd" },
            lua = { "stylua" },
            markdown = { "prettierd" },
            python = { "isort", "black" },
            sh = { "shfmt" },
            svelte = { "prettierd" },
            typescript = { "prettierd", "eslint_d" },
            typescriptreact = { "prettierd", "eslint_d" },
            yaml = { "prettierd" },
        },
        format_on_save = {
            timeout_ms = 700,
            -- lsp_fallback = true,
            async = true,
            -- quiet = true,
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
