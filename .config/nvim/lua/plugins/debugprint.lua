return {
    "andrewferrier/debugprint.nvim",
    enabled = not vim.g.is_quick_notes_mode,
    config = true,
    lazy = false,
    version = "*",
    opts = {
        keymaps = {
            normal = {
                plain_below = "<leader>lp",
                plain_above = "<leader>lP",
                variable_below = "<leader>lv",
                variable_above = "<leader>lV",
            },
            visual = {
                variable_below = "<leader>lv",
                variable_above = "<leader>lV",
            },
        },
    },
    keys = {
        { "<leader>ll", "<cmd>Debugprint search<cr>", desc = "Show Debug Prints" },
        { "<leader>ld", "<cmd>Debugprint delete<cr>", desc = "Delete Debug Prints" },
    },
}
