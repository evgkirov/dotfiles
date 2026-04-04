vim.pack.add({
    "https://github.com/nanozuki/tabby.nvim",
})

require("tabby").setup()

vim.keymap.set("n", "<leader><space>", "<cmd>Tabby jump_to_tab<cr>", { desc = "Jump to Tab" })
vim.keymap.set("n", "<leader>tt", "<cmd>Tabby pick_window<cr>", { desc = "Pick Window" })
