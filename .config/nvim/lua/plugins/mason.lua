return {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup({
            ui = {
                border = "single",
            },
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "cssls",
                "html",
                "lua_ls",
                "pyright",
                "tsserver",
            },
            automatic_installation = false,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "black",
                "isort",
                "prettierd",
                "shfmt",
                "stylua",
                "eslint_d",
                -- "pylint",
            },
        })
    end,
}
