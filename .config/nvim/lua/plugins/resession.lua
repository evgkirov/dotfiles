return {
    "stevearc/resession.nvim",
    version = "*",
    lazy = false,
    opts = {
        autosave = {
            enabled = true,
            interval = 60,
            notify = false,
        },
        extensions = {
            overseer = {
                autostart_on_load = false,
            },
            tabby = {},
        },
    },
    init = function()
        -- Create one session per directory
        -- https://github.com/stevearc/resession.nvim?tab=readme-ov-file#create-one-session-per-directory
        local resession = require("resession")
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                -- Only load the session if nvim was started with no args and without reading from stdin
                if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
                    -- Save these to a different directory, so our manual sessions don't get polluted
                    resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
                    vim.schedule(function()
                        vim.cmd("doautoall BufReadPost")
                    end)
                end
            end,
            nested = true,
        })
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
            end,
        })
        vim.api.nvim_create_autocmd("StdinReadPre", {
            callback = function()
                -- Store this for later
                vim.g.using_stdin = true
            end,
        })
    end,
}
