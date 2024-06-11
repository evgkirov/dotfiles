require("helpers.which-key-config").r = { name = "󱤵 Run..." }

return {
    "stevearc/overseer.nvim",
    dependencies = {
        "stevearc/dressing.nvim",
    },
    config = true,
    opts = {
        strategy = { "jobstart", use_terminal = false }, -- https://github.com/stevearc/overseer.nvim/issues/202
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
    },
}
