return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        shade_terminals = false,
    },
    init = function()
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                require("helpers.lazygit"):shutdown()
                require("helpers.lazydocker"):shutdown()
            end,
        })
    end,
    keys = {
        {
            "<leader>gs",
            function()
                require("helpers.lazygit"):toggle()
            end,
            desc = "Git Status (LazyGit)",
        },
        {
            "<leader>ds",
            function()
                require("helpers.lazydocker"):toggle()
            end,
            desc = "Docker Status (LazyDocker)",
        },
    },
}
