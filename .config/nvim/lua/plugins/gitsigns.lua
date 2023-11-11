return {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            untracked = { text = "" },
        },
    },
    keys = {
        {
            "]c",
            function()
                local gitsigns = require("gitsigns")
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gitsigns.next_hunk()
                end)
                return "<Ignore>"
            end,
            desc = "Next change",
        },
        {
            "[c",
            function()
                local gitsigns = require("gitsigns")
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gitsigns.prev_hunk()
                end)
                return "<Ignore>"
            end,
            desc = "Previous change",
        },
        { "<leader>ph", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
        { "<leader>pd", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Preview Deleted lines" },
        -- { "<leader>sh", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
        -- { "<leader>uh", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Unstage Hunk" },
        { "<leader>rh", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
        { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Git Blame" },
    },
}
