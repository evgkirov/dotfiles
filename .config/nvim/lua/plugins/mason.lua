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

                "lua_ls",

                "html@4.8.0",
                "cssls@4.8.0",
                "tsserver",
                "eslint@4.8.0",
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
                "isort",
                "prettierd",
                "shfmt",
                "stylua",
                "eslint_d",
                -- "pylint",
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
