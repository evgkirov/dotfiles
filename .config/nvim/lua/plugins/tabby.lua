return {
    "nanozuki/tabby.nvim",
    event = "VimEnter",
    config = true,
    keys = {
        { "<leader><space>", "<cmd>Tabby jump_to_tab<cr>", desc = "Jump to Tab" },
        { "<leader>tt", "<cmd>Tabby pick_window<cr>", desc = "Pick Window" },
    },
}
