return {
    "f-person/auto-dark-mode.nvim",
    dependencies = {
        "sainnhe/everforest",
    },
    priority = 1000,
    lazy = false,
    config = true,
    init = function()
        vim.g.everforest_background = "hard"
        vim.cmd("colorscheme everforest")
        vim.o.termguicolors = true
    end,
}
