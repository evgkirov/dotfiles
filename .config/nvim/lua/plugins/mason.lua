return {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({})

        mason_lspconfig.setup({
            ensure_installed = {
                -- "tsserver",
                -- "html",
                -- "cssls",
                -- "tailwindcss",
                -- "svelte",
                "lua_ls",
                -- "graphql",
                -- "emmet_ls",
                -- "prismals",
                "pyright",
            },
            automatic_installation = true,
        })
    end,
}
