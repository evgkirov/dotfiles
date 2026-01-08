return {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    opts = {
        open_for_directories = true,
        keymaps = {
            open_file_in_horizontal_split = "<c-s>",
            grep_in_directory = "<c-p>pap",
            open_and_pick_window = "<S-CR>",
        },
    },
    config = function(_, opts)
        require("yazi").setup(opts)
        vim.api.nvim_set_hl(0, "YaziFloatBorder", { link = "Grey" })
    end,
    init = function()
        vim.g.loaded_netrwPlugin = 1
    end,
    keys = {
        {
            "-",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "File Explorer",
        },
        {
            "_",
            "<cmd>Yazi cwd<cr>",
            desc = "File Explorer (Project Root)",
        },
    },
}
