return {
    "williamboman/mason.nvim",
    version = "*",
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

                "typos_lsp",

                "lua_ls",

                "html",
                "cssls",
                "ts_ls",
                "eslint",
                "jsonls",

                "basedpyright", -- autocompletions
                "pylsp", -- refactorings (with rope - see below)
                "ruff", -- diagnostics
            },
            automatic_installation = false,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "black",
                "djlint",
                "eslint_d",
                "isort",
                "prettierd",
                "shfmt",
                "stylua",
            },
        })

        local pylsp = require("mason-registry").get_package("python-lsp-server")
        pylsp:on("install:success", function()
            local function mason_package_path(package)
                local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
                return path
            end

            local path = mason_package_path("python-lsp-server")
            local command = path .. "/venv/bin/pip"
            local args = {
                "install",
                "pylsp-rope",
            }
            require("plenary.job")
                :new({
                    command = command,
                    args = args,
                    cwd = path,
                })
                :start()
        end)
    end,
}
