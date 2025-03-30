-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
vim.api.nvim_create_user_command("FormatDisable", function(args)
    vim.g.disable_autoformat = true
end, {
    desc = "Disable autoformat-on-save",
})

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})

return {
    "stevearc/conform.nvim",
    version = "*",
    event = "BufWritePre",
    opts = {
        formatters_by_ft = {
            bash = { "shfmt" },
            css = { "prettierd" },
            graphql = { "prettierd" },
            html = { "prettierd" },
            htmldjango = { "djlint" },
            javascript = { "prettierd", "eslint_d" },
            javascriptreact = { "prettierd", "eslint_d" },
            json = { "prettierd" },
            lua = { "stylua" },
            markdown = { "prettierd" },
            -- python = { "isort", "black" },
            python = { "ruff" },
            sh = { "shfmt" },
            svelte = { "prettierd" },
            typescript = { "prettierd", "eslint_d" },
            typescriptreact = { "prettierd", "eslint_d" },
            yaml = { "prettierd" },
            zsh = { "beautysh" },
        },
        -- log_level = vim.log.levels.DEBUG,
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat then
                return
            end

            return { timeout_ms = 2000 }
        end,
    },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true })
            end,
            desc = "Format",
        },
    },
}
