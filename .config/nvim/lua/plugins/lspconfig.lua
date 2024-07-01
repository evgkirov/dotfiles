require("helpers.which-key-config").c = { name = "󰅩 Code..." }
-- loosely based on https://raw.githubusercontent.com/josean-dev/dev-environment-files/1bcf8bfd532c1fe549798a0f4a3ab351970de3d3/.config/nvim/lua/josean/plugins/lsp/lspconfig.lua

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim",
        -- { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local neodev = require("neodev")
        neodev.setup({})

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local python_auto_venv = require("helpers.python-auto-venv")

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.diagnostic.config({
            virtual_text = false,
        })

        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, silent = true }

            opts.desc = "Rename"
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

            opts.desc = "Action..."
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "?", vim.lsp.buf.code_action, opts)
            vim.keymap.set("v", "?", vim.lsp.buf.code_action, opts)

            opts.desc = "Hover"
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            opts.desc = "Open definition"
            vim.keymap.set("n", "go", vim.lsp.buf.definition, opts)

            opts.desc = "Previous diagnostic"
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.goto_prev({ float = true })
            end, opts)

            opts.desc = "Next diagnostic"
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.goto_next({ float = true })
            end, opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- CSS, SCSS, LESS
        lspconfig.cssls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- javascript and typescript w/react
        lspconfig.tsserver.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.eslint.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- html
        lspconfig.html.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "htmldjango" },
        })

        -- lua
        lspconfig.lua_ls.setup({
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
        python_auto_venv.create_venv()
        local python_path = python_auto_venv.python_path()
        local lsp_restarted = false

        lspconfig.basedpyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            on_init = function(client)
                -- Ugly hack because pyright/basedpyright for some reason doesn't pick up the python path
                vim.defer_fn(function()
                    local attached_buffers = vim.lsp.get_buffers_by_client_id(client.id)
                    vim.cmd("split")
                    vim.cmd("b " .. attached_buffers[1])
                    vim.cmd("PyrightSetPythonPath " .. python_path)
                    vim.cmd("q")
                    if not lsp_restarted then
                        lsp_restarted = true
                        vim.cmd("LspRestart basedpyright")
                    end
                end, 100)
            end,
            settings = {
                basedpyright = {
                    analysis = {
                        typeCheckingMode = "standard",
                        -- typeCheckingMode = "off",
                        diagnosticMode = "openFilesOnly",
                    },
                },
                python = {
                    pythonPath = python_path,
                },
            },
        })
        vim.highlight.priorities.semantic_tokens = 95 -- https://github.com/DetachHead/basedpyright/issues/176#issuecomment-2016608736

        lspconfig.pylsp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                pylsp = {
                    plugins = {
                        rope = { enabled = true },
                        autopep8 = { enabled = false },
                        flake8 = { enabled = false },
                        jedi_completion = { enabled = false },
                        jedi_definition = { enabled = false },
                        jedi_hover = { enabled = false },
                        jedi_references = { enabled = false },
                        jedi_signature_help = { enabled = false },
                        jedi_symbols = { enabled = false },
                        mccabe = { enabled = false },
                        preload = { enabled = false },
                        pycodestyle = { enabled = false },
                        pydocstyle = { enabled = false },
                        pyflakes = { enabled = false },
                        pylint = { enabled = false },
                        rope_autoimport = { enabled = false },
                        rope_completion = { enabled = false },
                        yapf = { enabled = false },
                    },
                },
            },
        })

        lspconfig.ruff.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}
