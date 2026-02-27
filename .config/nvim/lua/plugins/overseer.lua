return {
    "stevearc/overseer.nvim",
    enabled = not vim.g.is_quick_notes_mode,
    version = "*",
    lazy = false,
    config = true,
    keys = {
        {
            "<leader>rr",
            function()
                vim.cmd("OverseerOpen! bottom")
                vim.cmd("OverseerRun")
            end,
            desc = "󰐊 Run task",
        },
        {
            "<leader>rR",
            function()
                vim.cmd("OverseerOpen! bottom")
                vim.cmd("OverseerShell")
            end,
            desc = "󰐊 Run shell",
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
                if vim.fn.filereadable("bin/dev-up.sh") == 1 then
                    vim.cmd("OverseerShell ./bin/dev-up.sh --app -d")
                else
                    vim.cmd("OverseerShell docker compose up -d")
                end
            end,
            desc = "docker compose up -d",
        },
        {
            "<leader>dU",
            function()
                vim.cmd("OverseerOpen! bottom")
                if vim.fn.filereadable("bin/dev-up.sh") == 1 then
                    vim.cmd("OverseerShell ./bin/dev-up.sh --app -d")
                else
                    vim.cmd("OverseerShell docker compose up -d --build")
                end
            end,
            desc = "docker compose up -d --build",
        },
        {
            "<leader>dd",
            function()
                vim.cmd("OverseerOpen! bottom")
                if vim.fn.filereadable("bin/dev-down.sh") == 1 then
                    vim.cmd("OverseerShell ./bin/dev-down.sh")
                else
                    vim.cmd("OverseerShell docker compose down")
                end
            end,
            desc = "docker compose down",
        },
        {
            "<leader>dD",
            function()
                vim.cmd("OverseerOpen! bottom")
                local down_cmd = "docker compose down"
                local up_cmd = "docker compose up -d"

                if vim.fn.filereadable("bin/dev-down.sh") == 1 then
                    down_cmd = "./bin/dev-down.sh"
                end

                if vim.fn.filereadable("bin/dev-up.sh") == 1 then
                    up_cmd = "./bin/dev-up.sh --app -d"
                end

                vim.cmd("OverseerShell " .. down_cmd .. " && " .. up_cmd)
            end,
            desc = "docker compose down & up",
        },
        {
            "<leader>deu",
            function()
                vim.cmd("OverseerOpen! bottom")
                vim.cmd("OverseerShell orbctl start")
            end,
            desc = "orbctl start",
        },
        {
            "<leader>ded",
            function()
                vim.cmd("OverseerOpen! bottom")
                vim.cmd("OverseerShell orbctl stop")
            end,
            desc = "orbctl stop",
        },
    },
}
