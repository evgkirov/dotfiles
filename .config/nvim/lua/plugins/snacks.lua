return {
    "folke/snacks.nvim",
    version = "*",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {

        -- modules
        bigfile = { enabled = true, notify = false },
        indent = {
            enabled = true,
            indent = { char = "⎸" },
            scope = { char = "⎸" },
            animate = { enabled = false },
        },
        image = { enabled = true, convert = { notify = true } },
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
        quickfile = { enabled = true },
        scratch = {
            enabled = true,
            win = { backdrop = false },
        },
        terminal = { enabled = true, win = { backdrop = false } },

        -- styles
        styles = {
            scratch = { wo = { winhighlight = "Normal:Normal,FloatBorder:Normal" }, footer_keys = false },
            terminal = {
                wo = {
                    winhighlight = "Normal:Normal,FloatBorder:Normal",
                },
                border = true,
                keys = {
                    term_normal = {
                        "<esc>",
                        function(self)
                            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                            if self.esc_timer:is_active() then
                                self.esc_timer:stop()
                                self:hide()
                            else
                                self.esc_timer:start(200, 0, function() end)
                                return "<esc>"
                            end
                        end,
                        mode = "t",
                        expr = true,
                        desc = "Double escape to normal mode",
                    },
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
                Snacks.picker({
                    finder = "proc",
                    cmd = "fd",
                    args = { "--type", "d", "--hidden", "--color", "never", "-E", ".git" },
                    transform = function(item, ctx)
                        item.file = item.text:gsub("/$", "")
                        item.dir = true
                        item.cwd = ctx.picker:cwd()
                    end,
                    format = "file",
                    title = "Directory",
                })
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

        -- picker: misc
        {
            "<f1>",
            function()
                Snacks.picker.help()
            end,
            desc = "Help",
        },
        {
            "<leader>fp",
            function()
                Snacks.picker.pickers()
            end,
            desc = "Picker",
        },

        -- scratch
        {
            "<leader>b",
            function()
                Snacks.scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>B",
            function()
                Snacks.scratch.select()
            end,
            desc = "Select Scratch Buffer",
        },

        -- terminal
        {
            "<leader>gs",
            function()
                Snacks.terminal.toggle("lazygit")
            end,
            desc = "Git Status (LazyGit)",
        },
        {
            "<leader>ds",
            function()
                Snacks.terminal.toggle("lazydocker")
            end,
            desc = "Docker Status (LazyDocker)",
        },
        {
            "<leader>cc",
            function()
                local cwd = vim.fn.getcwd()
                if string.find(cwd, "/agvend") then
                    Snacks.terminal.toggle("codex resume")
                else
                    Snacks.terminal.toggle("claude")
                end
            end,
            desc = "Code Assistant (Codex / Claude)",
        },
    },
}
