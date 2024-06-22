return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    keys = {
        {
            "<leader>cr",
            function()
                require("refactoring").select_refactor()
            end,
            mode = { "n", "v" },
            desc = "Refactor...",
        },
    },
}
