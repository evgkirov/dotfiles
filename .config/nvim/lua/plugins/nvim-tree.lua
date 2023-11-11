return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
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

        -- workaround for auto-session
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
    keys = {
        { "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer (nvim-tree)" } },
        { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in the expolerer" } },
        { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", { desc = "Collapse file explorer" } },
        { "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh file explorer" } },
    },
}
