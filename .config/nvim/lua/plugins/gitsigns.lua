return {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = true,
    opts = {},
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
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
        { "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Preview deleted lines" },
        -- { "<leader>sh", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
        -- { "<leader>uh", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Unstage Hunk" },
        { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
        { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame" },
    },
}
