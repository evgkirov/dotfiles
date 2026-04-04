vim.pack.add({
    {
        src = "https://github.com/andrewferrier/debugprint.nvim",
        version = vim.version.range("*"),
    },
})

require("debugprint").setup({
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
})

vim.keymap.set("n", "<leader>ll", "<cmd>Debugprint search<cr>", { desc = "Show Debug Prints" })
vim.keymap.set("n", "<leader>ld", "<cmd>Debugprint delete<cr>", { desc = "Delete Debug Prints" })
