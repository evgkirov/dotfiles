vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim", version = vim.version.range("*") },
})

require("gitsigns").setup({
    signs = {
        add = { text = "░" },
        change = { text = "░" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "▓" },
        untracked = { text = "┆" },
    },
    signs_staged = {
        add = { text = "░" },
        change = { text = "░" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "▓" },
        untracked = { text = "┆" },
    },
    sign_priority = 20,
})

vim.keymap.set("n", "]c", function()
    local gitsigns = require("gitsigns")
    if vim.wo.diff then
        return "]c"
    end
    vim.schedule(function()
        gitsigns.next_hunk()
    end)
    return "<Ignore>"
end, { expr = true, desc = "Next change" })

vim.keymap.set("n", "[c", function()
    local gitsigns = require("gitsigns")
    if vim.wo.diff then
        return "[c"
    end
    vim.schedule(function()
        gitsigns.prev_hunk()
    end)
    return "<Ignore>"
end, { expr = true, desc = "Previous change" })

vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Preview deleted lines" })
-- vim.keymap.set("n", "<leader>sh", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage Hunk" })
-- vim.keymap.set("n", "<leader>uh", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Unstage Hunk" })
vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame" })
