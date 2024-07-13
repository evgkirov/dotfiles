local slow_format_filetypes = {}

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
        -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#automatically-run-slow-formatters-async
        format_on_save = function(bufnr)
            if slow_format_filetypes[vim.bo[bufnr].filetype] then
                return
            end
            local function on_format(err)
                if err and err:match("timeout$") then
                    slow_format_filetypes[vim.bo[bufnr].filetype] = true
                end
            end

            return { timeout_ms = 200, lsp_format = "fallback" }, on_format
        end,
        format_after_save = function(bufnr)
            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                return
            end
            return { lsp_format = "fallback" }
        end,
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
