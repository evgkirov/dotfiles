require("helpers.which-key-config").c = { name = "󰅩 Code..." }
-- loosely based on https://raw.githubusercontent.com/josean-dev/dev-environment-files/1bcf8bfd532c1fe549798a0f4a3ab351970de3d3/.config/nvim/lua/josean/plugins/lsp/lspconfig.lua

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local neodev = require("neodev")
        neodev.setup({})

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, silent = true }

            opts.desc = "Rename"
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

            opts.desc = "Action..."
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Info (hover)"
            vim.keymap.set("n", "<leader>ci", vim.lsp.buf.hover, opts)

            opts.desc = "Go to definition"
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, opts)

            opts.desc = "Go to definition (horizontal split)"
            vim.keymap.set("n", "<leader>ch", "<cmd>belowright split | lua vim.lsp.buf.definition()<cr>", opts)

            opts.desc = "Go to definition (vertical split)"
            vim.keymap.set("n", "<leader>cv", "<cmd>belowright vsplit | lua vim.lsp.buf.definition()<cr>", opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- CSS, SCSS, LESS
        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- javascript and typescript w/react
        lspconfig["tsserver"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- html
        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "htmldjango" },
        })

        -- lua
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        })

        -- python
        -- require("helpers.python-auto-venv").create_pyright_config()
        require("helpers.python-auto-venv").create_venv()
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
