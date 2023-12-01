require("helpers.which-key-config").e = { name = "󰙅 File explorer..." }

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    priority = 900,
    init = function()
        local nvim_tree = require("nvim-tree")

        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvim_tree.setup({

            sync_root_with_cwd = true,
            actions = {
                change_dir = {
                    global = true,
                },
            },

            view = {
                width = 42,
                relativenumber = true,
            },

            renderer = {
                root_folder_label = ":t",
                --root_folder_label = false,
                icons = {
                    git_placement = "after",
                },
            },
        })
    end,
    keys = {
        { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle" },
        { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Focus file" },
        { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", desc = "Collapse" },
        { "<leader>er", "<cmd>NvimTreeRefresh<cr>", desc = "Refresh" },
    },
}
