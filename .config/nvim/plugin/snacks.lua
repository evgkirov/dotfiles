vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim", version = vim.version.range("*") },
})

Snacks.setup({

    -- Bigfile
    bigfile = { enabled = true, notify = false },

    -- Gitbrowse
    gitbrowse = { enabled = true },

    -- Image
    image = { enabled = true, convert = { notify = true } },

    -- Indent
    indent = { enabled = true, animate = { enabled = false } },
    -- indent = { char = "⎸" },
    -- scope = { char = "⎸" },

    -- Picker
    picker = {
        enabled = true,
        layout = { layout = { backdrop = false } },
        win = {
            input = { keys = { ["<C-f>"] = { "focus_preview", mode = { "i", "n" } } } },
            list = { keys = {} },
            preview = { keys = {} },
        },
    },

    -- Quickfile
    quickfile = { enabled = true },

    -- Terminal
    terminal = { win = { backdrop = false } },

    -- Scratch
    scratch = {
        enabled = true,
        win = { backdrop = false },
    },

    -- Styles
    styles = {
        scratch = { wo = { winhighlight = "Normal:Normal,FloatBorder:Normal" }, footer_keys = false },
        terminal = {
            wo = { winhighlight = "Normal:Normal,FloatBorder:Normal" },
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
})

-- Picker (find)

vim.keymap.set("n", "<leader>ff", function()
    Snacks.picker.smart({ hidden = true, filter = { cwd = true } })
end, { desc = "File (Smart)" })

vim.keymap.set("n", "<leader>fF", function()
    Snacks.picker.files({ hidden = true, ignored = true })
end, { desc = "File (Dumb)" })

vim.keymap.set("n", "<leader>fb", function()
    Snacks.picker.buffers()
end, { desc = "Buffer" })

vim.keymap.set("n", "<leader>fr", function()
    Snacks.picker.resume()
end, { desc = "Resume" })

vim.keymap.set("n", "<leader>fq", function()
    Snacks.picker.qflist()
end, { desc = "Quickfix" })

vim.keymap.set("n", "<leader>fg", function()
    Snacks.picker.grep({ hidden = true })
end, { desc = "Grep" })

vim.keymap.set({ "n", "x" }, "<leader>f*", function()
    Snacks.picker.grep_word({ hidden = true })
end, { desc = "Grep Word" })

vim.keymap.set("n", "<leader>fo", function()
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
end, { desc = "Directory" })

vim.keymap.set("n", "<leader>fd", function()
    Snacks.picker.lsp_symbols({ keep_parents = true, layout = "ivy_split" })
end, { desc = "Document Symbols" })

vim.keymap.set("n", "<leader>fD", function()
    Snacks.picker.treesitter({ layout = "ivy_split" })
end, { desc = "Treesitter Symbols" })

vim.keymap.set("n", "<leader>fs", function()
    Snacks.picker.lsp_workspace_symbols()
end, { desc = "Workspace Symbols" })

-- Git & Gitbrowse

vim.keymap.set({ "n", "v" }, "<leader>gh", function()
    Snacks.gitbrowse()
end, { desc = "Git Browse (Current File)" })

vim.keymap.set("n", "<leader>gH", function()
    Snacks.gitbrowse({ what = "repo" })
end, { desc = "Git Browse (Repo)" })

vim.keymap.set("n", "<leader>gf", function()
    Snacks.picker.git_status()
end, { desc = "Git Status (File Picker)" })

vim.keymap.set("n", "<leader>gl", function()
    Snacks.picker.git_log()
end, { desc = "Git Log" })

vim.keymap.set("n", "<leader>gL", function()
    Snacks.picker.git_log_file()
end, { desc = "Git Log (Current File)" })

-- LSP

vim.keymap.set("n", "gd", function()
    Snacks.picker.lsp_definitions({ auto_confirm = false, layout = "bottom" })
end, { desc = "View Definition" })

vim.keymap.set("n", "go", function()
    Snacks.picker.lsp_definitions({ layout = "bottom" })
end, { desc = "Go to Definition" })

vim.keymap.set("n", "gr", function()
    Snacks.picker.lsp_references({ include_current = true, auto_confirm = false, layout = "bottom" })
end, { desc = "View References" })

vim.keymap.set("n", "<leader>cd", function()
    Snacks.picker.diagnostics_buffer({ layout = "ivy_split" })
end, { desc = "Diagnostics (Current File)" })

vim.keymap.set("n", "<leader>cD", function()
    Snacks.picker.diagnostics({ layout = "bottom" })
end, { desc = "Diagnostics" })

-- Picker (misc)

vim.keymap.set("n", "<f1>", function()
    Snacks.picker.help()
end, { desc = "Help" })

vim.keymap.set("n", "<leader>fp", function()
    Snacks.picker.pickers()
end, { desc = "Picker" })

vim.keymap.set({ "n", "i" }, "<c-e>", function()
    Snacks.picker.icons({ layout = { preset = "dropdown", hidden = { "preview" } } })
end, { desc = "Icons" })

-- Terminal

vim.keymap.set("n", "<leader>gs", function()
    Snacks.terminal.toggle("lazygit")
end, { desc = "Git Status (LazyGit)" })

vim.keymap.set("n", "<leader>ds", function()
    Snacks.terminal.toggle("lazydocker")
end, { desc = "Docker Status (LazyDocker)" })

vim.keymap.set("n", "<leader>cc", function()
    local cwd = vim.fn.getcwd()
    if string.find(cwd, "/agvend") then
        Snacks.terminal.toggle("codex")
    else
        Snacks.terminal.toggle("opencode")
    end
end, { desc = "Code Assistant (Codex / OpenCode)" })

-- Scratch

vim.keymap.set("n", "<leader>b", function()
    Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })

vim.keymap.set("n", "<leader>B", function()
    Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })
