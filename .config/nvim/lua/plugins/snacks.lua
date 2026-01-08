return {
    "folke/snacks.nvim",
    version = "*",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            enabled = true,
            layout = {
                layout = {
                    backdrop = false,
                },
            },
            win = {
                input = {
                    keys = {
                        ["<C-f>"] = { "focus_preview", mode = { "i", "n" } },
                    },
                },
                list = {
                    keys = {},
                },
                preview = {
                    keys = {},
                },
            },
        },
    },
    keys = {
        -- picker: find
        {
            "<leader>ff",
            function()
                Snacks.picker.smart({ hidden = true, filter = { cwd = true } })
            end,
            desc = "File (Smart)",
        },
        {
            "<leader>fF",
            function()
                Snacks.picker.files({ hidden = true, ignored = true })
            end,
            desc = "File (Dumb)",
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffer",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.resume()
            end,
            desc = "Resume",
        },
        {
            "<leader>fq",
            function()
                Snacks.picker.qflist()
            end,
            desc = "Quickfix",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep({ hidden = true })
            end,
            desc = "Grep",
        },
        {
            "<leader>f*",
            function()
                Snacks.picker.grep_word({ hidden = true })
            end,
            desc = "Grep Word",
            mode = { "n", "x" },
        },
        {
            "<leader>fo",
            function()
                Snacks.picker.files({ hidden = true, args = { "--type", "d" } })
            end,
            desc = "Directory",
        },
        {
            "<leader>fs",
            function()
                Snacks.picker.lsp_symbols({ keep_parents = true, layout = "ivy_split" })
            end,
            desc = "Document Symbols",
        },
        {
            "<leader>fS",
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "Workspace Symbols",
        },

        -- picker: git
        {
            "<leader>gf",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git Status (File Picker)",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git Log",
        },
        {
            "<leader>gL",
            function()
                Snacks.picker.git_log_file()
            end,
            desc = "Git Log (Current File)",
        },

        -- picker: code/lsp
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions({ auto_confirm = false, layout = "bottom" })
            end,
            desc = "View Definition",
        },
        {
            "go",
            function()
                Snacks.picker.lsp_definitions({ layout = "bottom" })
            end,
            desc = "Go to Definition",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references({
                    include_current = true,
                    auto_confirm = false,
                    layout = "bottom",
                })
            end,
            desc = "View References",
        },
        {
            "<leader>cd",
            function()
                Snacks.picker.diagnostics_buffer({ layout = "ivy_split" })
            end,
            desc = "Diagnostics (Current File)",
        },
        {
            "<leader>cD",
            function()
                Snacks.picker.diagnostics({ layout = "bottom" })
            end,
            desc = "Diagnostics",
        },
    },
}
