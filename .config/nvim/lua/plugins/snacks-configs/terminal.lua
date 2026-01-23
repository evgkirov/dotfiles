return {
    opts = {
        enabled = true,
        win = { backdrop = false },
    },
    styles = {
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
    keys = {
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
                    Snacks.terminal.toggle("codex")
                else
                    Snacks.terminal.toggle("claude")
                end
            end,
            desc = "Code Assistant (Codex / Claude)",
        },
    },
}
