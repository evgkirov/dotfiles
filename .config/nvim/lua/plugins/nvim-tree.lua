return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    commit = "a2aaf8b430c11af36b869cf1c0ad2f7c8ceeaf2c",
    lazy = false,
    priority = 900,
    config = function()
        local nvimtree = require("nvim-tree")

        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({

            sync_root_with_cwd = true,
            actions = {
                change_dir = {
                    global = true,
                },
            },

            view = {
                width = 40,
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
        { "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer (nvim-tree)" } },
        { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in the expolerer" } },
        { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", { desc = "Collapse file explorer" } },
        { "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh file explorer" } },
    },
}
