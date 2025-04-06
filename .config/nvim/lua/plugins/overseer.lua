return {
    "stevearc/overseer.nvim",
    version = "*",
    dependencies = {
        "stevearc/dressing.nvim",
    },
    config = true,
    opts = {
        -- strategy = { "jobstart", use_terminal = false }, -- https://github.com/stevearc/overseer.nvim/issues/202
        bundles = {
            autostart_on_load = false,
        },
        templates = {
            "builtin",
            "docker_compose.up",
            "docker_compose.down",
        },
    },
    keys = {
        {
            "<leader>rr",
            function()
                vim.cmd("OverseerOpen! bottom")
                vim.cmd("OverseerRun")
            end,
            desc = "󰐊 Run task",
        },
        { "<leader>rt", "<cmd>OverseerToggle bottom<cr>", desc = " Toggle Overseer" },
        { "<leader>rs", "<cmd>OverseerQuickAction restart<cr>", desc = " Restart Task" },
        { "<leader>rf", "<cmd>OverseerQuickAction open float<cr>", desc = " Open - Float" },
        { "<leader>rq", "<cmd>OverseerQuickAction<cr>", desc = " Quick Action (for current task)" },
        { "<leader>ra", "<cmd>OverseerTaskAction<cr>", desc = " Task Action (select task and run action)" },

        {
            "<leader>du",
            function()
                vim.cmd("OverseerOpen! bottom")
                vim.cmd("OverseerRunCmd docker compose up -d")
            end,
            desc = "docker compose up -d",
        },
        {
            "<leader>dU",
            function()
                vim.cmd("OverseerOpen! bottom")
                vim.cmd("OverseerRunCmd docker compose up -d --build")
            end,
            desc = "docker compose up -d --build",
        },
        {
            "<leader>dd",
            function()
                vim.cmd("OverseerOpen! bottom")
                vim.cmd("OverseerRunCmd docker compose down")
            end,
            desc = "docker compose down",
        },
        {
            "<leader>dD",
            function()
                vim.cmd("OverseerOpen! bottom")
                vim.cmd("OverseerRunCmd docker compose down && docker compose up -d")
            end,
            desc = "docker compose down & up",
        },
    },
}
