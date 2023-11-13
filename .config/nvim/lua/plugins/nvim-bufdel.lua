return {
    "ojroques/nvim-bufdel",
    opts = {
        quit = false,
    },
    keys = {
        { "<leader>x", "<cmd>BufDel<cr>", desc = "Close buffer" },
        { "<leader>ex", "<cmd>BufDelAll<cr><cmd>NvimTreeCollapse<cr>", desc = "Clear context" },
    },
}
