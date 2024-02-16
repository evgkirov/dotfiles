require("helpers.which-key-config").f = { name = "󰍉 Find..." }

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/aerial.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
            },
            pickers = {
                find_files = {
                    find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
                    file_ignore_patterns = { "node_modules", "\\.git" },
                    hidden = true,
                },
                lsp_dynamic_workspace_symbols = {
                    ignore_symbols = { "variable" },
                },
                lsp_document_symbols = {
                    ignore_symbols = { "variable" },
                },
            },
            extensions = {
                aerial = {
                    show_lines = false,
                    -- Display symbols as <root>.<parent>.<symbol>
                    show_nesting = {
                        ["_"] = true, -- This key will be the default
                    },
                },
            },
        })
        telescope.load_extension("fzf")
    end,
    keys = {
        { "<Tab>", "<cmd>Telescope buffers sort_lastused=true<cr>", desc = "Buffers" },
        { "<F1>", "<cmd>Telescope help_tags<cr>", desc = "Help" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Grep string under cursor" },
        { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
        -- { "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
        { "<leader>fd", "<cmd>Telescope aerial<cr>", desc = "Document symbols" },
        { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
    },
}
