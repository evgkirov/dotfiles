return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
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
            "<leader>lg",
            function()
                require("helpers.lazygit"):toggle()
            end,
        },
        {
            "<leader>ld",
            function()
                require("helpers.lazydocker"):toggle()
            end,
        },
    },
}
