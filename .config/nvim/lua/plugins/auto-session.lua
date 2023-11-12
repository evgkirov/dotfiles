return {
    "rmagatti/auto-session",
    dependencies = {
        "nvim-tree/nvim-tree.lua", -- so it can restore it
    },
    lazy = false,
    priority = 800,
    config = true,
    init = function()
        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            pattern = "NvimTree*",
            callback = function()
                local api = require("nvim-tree.api")
                local view = require("nvim-tree.view")

                if not view.is_visible() then
                    api.tree.open()
                end
            end,
        })
    end,
}
