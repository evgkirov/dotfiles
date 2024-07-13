return {
    "stevearc/overseer.nvim",
    dependencies = {
        "stevearc/dressing.nvim",
    },
    config = true,
    opts = {
        strategy = { "jobstart", use_terminal = false }, -- https://github.com/stevearc/overseer.nvim/issues/202
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
        { "<leader>re", "<cmd>OverseerToggle bottom<cr>", desc = "󰐑 Toggle Overseer" },
        -- { "<leader>rw", "<cmd>OverseerSaveBundle<cr>", desc = "󰆓 Save Bundle" },
        -- { "<leader>rl", "<cmd>OverseerLoadBundle!<cr>", desc = " Load Bundle" },
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
    },
}
