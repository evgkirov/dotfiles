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

        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, silent = true }

            opts.desc = "Rename"
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

            opts.desc = "Action..."
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Info (hover)"
            vim.keymap.set("n", "<leader>ci", vim.lsp.buf.hover, opts)
            -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            opts.desc = "Open definition"
            -- vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "go", vim.lsp.buf.definition, opts)

            -- opts.desc = "Go to definition (horizontal split)"
            -- vim.keymap.set("n", "<leader>ch", "<cmd>belowright split | lua vim.lsp.buf.definition()<cr>", opts)
            --
            -- opts.desc = "Go to definition (vertical split)"
            -- vim.keymap.set("n", "<leader>cv", "<cmd>belowright vsplit | lua vim.lsp.buf.definition()<cr>", opts)
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
        lspconfig["eslint"].setup({
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
        python_auto_venv.create_venv()
        local python_path = python_auto_venv.python_path()
        -- print("Python path: " .. python_path)
        -- vim.lsp.set_log_level("debug")
        lspconfig["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            on_init = function(client)
                -- Workaround for when the Python path is ignored for some reason
                vim.defer_fn(function()
                    local attached_buffers = vim.lsp.get_buffers_by_client_id(client.id)
                    vim.cmd("split")
                    vim.cmd("b " .. attached_buffers[1])
                    vim.cmd("PyrightSetPythonPath " .. python_path)
                    vim.cmd("q")
                end, 1000)
            end,
            settings = {
                python = {
                    pythonPath = python_path,
                },
            },
        })
    end,
}
