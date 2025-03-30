-- loosely based on https://raw.githubusercontent.com/josean-dev/dev-environment-files/1bcf8bfd532c1fe549798a0f4a3ab351970de3d3/.config/nvim/lua/josean/plugins/lsp/lspconfig.lua

return {
    "neovim/nvim-lspconfig",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "saghen/blink.cmp",
        -- { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = " ",
                },
            },
            jump = {
                float = true,
            },
        })

        -- Spell checking
        lspconfig.typos_lsp.setup({
            init_options = {
                diagnosticSeverity = "Warning",
            },
        })

        -- CSS, SCSS, LESS
        lspconfig.cssls.setup({})

        -- javascript and typescript w/react
        lspconfig.ts_ls.setup({})
        lspconfig.eslint.setup({})

        -- html
        lspconfig.html.setup({
            filetypes = { "html", "htmldjango" },
        })

        -- json
        lspconfig.jsonls.setup({})

        -- python
        lspconfig.basedpyright.setup({
            settings = {
                basedpyright = {
                    analysis = {
                        typeCheckingMode = "standard",
                        -- diagnosticMode = "workspace",
                    },
                },
            },
        })
        lspconfig.ruff.setup({})

        -- lua
        -- "If you primarily use lua-language-server for Neovim"
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
        lspconfig.lua_ls.setup({
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath("config")
                        and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
                    then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            -- Depending on the usage, you might want to add additional paths here.
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        },
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    },
                })
            end,
            settings = {
                Lua = {},
            },
        })
    end,
}
