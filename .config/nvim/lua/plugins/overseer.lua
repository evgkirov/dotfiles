require("helpers.which-key-config").r = { name = "󱤵 Run..." }
require("helpers.which-key-config").r.m = { name = "󰍔 Markdown..." }

return {
    "stevearc/overseer.nvim",
    dependencies = {
        "stevearc/dressing.nvim",
    },
    config = true,
    opts = {
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
