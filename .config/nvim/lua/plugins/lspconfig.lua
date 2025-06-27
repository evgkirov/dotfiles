return {
    "neovim/nvim-lspconfig",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "saghen/blink.cmp",
        -- { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local warnig = true

        local servers = {

            -- Text
            typos_lsp = {
                init_options = {
                    diagnosticSeverity = "Warning",
                },
            },
            markdown_oxide = {},

            -- Web
            html = {
                filetypes = { "html", "htmldjango" },
            },
            cssls = {},
            ts_ls = {
                init_options = {
                    disableAutomaticTypingAcquisition = true,
                },
            },
            eslint = {},
            jsonls = {},

            -- Python
            basedpyright = {
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "standard",
                        },
                    },
                },
            },
            ruff = {},

            -- Lua (Neovim)
            -- "If you primarily use lua-language-server for Neovim"
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
            lua_ls = {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath("config")
                            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                        then
                            return
                        end
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            },
        }

        vim.highlight.priorities.semantic_tokens = 95 -- https://github.com/DetachHead/basedpyright/issues/176#issuecomment-2016608736

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

        for server, opts in pairs(servers) do
            vim.lsp.config(server, opts)
            vim.lsp.enable(server)
        end
    end,
}
