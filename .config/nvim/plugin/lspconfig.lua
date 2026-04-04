vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig", version = vim.version.range("*") },
})

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
        on_jump = function()
            vim.diagnostic.open_float()
        end,
    },
})

-- 󰓆 Text

vim.lsp.config("typos_lsp", {
    init_options = {
        diagnosticSeverity = "Warning",
    },
})
vim.lsp.enable("typos_lsp")

-- 󰖟 Web

vim.lsp.config("html", {
    filetypes = { "html", "htmldjango" },
})
vim.lsp.enable("html")

vim.lsp.config("ts_ls", {
    init_options = {
        disableAutomaticTypingAcquisition = true,
    },
})
vim.lsp.enable("ts_ls")

vim.lsp.enable("cssls")
vim.lsp.enable("eslint")
vim.lsp.enable("jsonls")

--  Python

vim.lsp.enable("ty")
vim.lsp.enable("ruff")

--  Beancount

vim.lsp.config("beancount", {
    init_options = {
        journal_file = require("helpers.beancount").beancount_file,
    },
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        client.server_capabilities.textDocumentSync.willSave = false
        client.server_capabilities.textDocumentSync.willSaveWaitUntil = false
    end,
})
vim.lsp.enable("beancount")

--  Lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
vim.lsp.config("lua_ls", {
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
})
vim.lsp.enable("lua_ls")
