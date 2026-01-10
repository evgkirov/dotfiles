return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    cmd = { "Obsidian" },
    opts = {
        legacy_commands = false,
        workspaces = {
            {
                name = "Personal",
                path = "~/Obsidian/Personal",
            },
        },
        ui = { enable = false },
    },
    -- init = function()
    --     vim.o.conceallevel = 2
    -- end,
    keys = {
        { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
        { "<leader>oa", "<cmd>Obsidian<cr>", desc = "Actions" },
    },
}
