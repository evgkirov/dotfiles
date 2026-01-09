return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        shade_terminals = false,
        float_opts = {
            border = vim.o.winborder,
        },
    },
    init = function()
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                require("helpers.lazygit"):shutdown()
                require("helpers.lazydocker"):shutdown()
                require("helpers.codex"):shutdown()
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
        {
            "<leader>cc",
            function()
                require("helpers.codex"):toggle()
            end,
            desc = "OpenAI Codex",
        },
    },
}
