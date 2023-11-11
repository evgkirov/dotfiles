-- loosely based on https://raw.githubusercontent.com/josean-dev/dev-environment-files/1bcf8bfd532c1fe549798a0f4a3ab351970de3d3/.config/nvim/lua/josean/plugins/lsp/lspconfig.lua

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            -- keymap here
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- LUA
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        -- PYTHON
        require("helpers.python-auto-venv").create_pyright_config()
        lspconfig["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                python = {
                    pythonPath = require("helpers.python-auto-venv").python_path(),
                },
            },
        })
    end,
}
