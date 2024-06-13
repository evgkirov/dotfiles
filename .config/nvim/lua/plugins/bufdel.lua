return {
    "ojroques/nvim-bufdel",
    opts = {
        quit = false,
    },
    keys = {
        -- { "<leader>x", "<cmd>BufDel<cr>", desc = "Close buffer" },
        { "<leader>x", "<cmd>bd<cr>", desc = "Close buffer" },
        { "<leader>X", "<cmd>BufDelAll<cr>", desc = "Clear context" },
    },
}
