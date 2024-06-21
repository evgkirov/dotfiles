require("helpers.which-key-config").f = { name = "󰍉 Find..." }

local function workspace_symbols_picker(filter) -- luacheck: ignore
    return function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = filter,
        })
    end
end
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
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                },
                prompt_prefix = "󰍉 ",
                preview = {
                    filesize_limit = 0.1,
                },
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-h>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab,
                        ["<C-o>"] = function(prompt_bufnr)
                            -- Use nvim-window-picker to choose the window by dynamically attaching a function
                            local action_set = require("telescope.actions.set")
                            local action_state = require("telescope.actions.state")

                            local picker = action_state.get_current_picker(prompt_bufnr)
                            picker.get_selection_window = function(picker, entry)
                                local picked_window_id = require("window-picker").pick_window()
                                    or vim.api.nvim_get_current_win()
                                -- Unbind after using so next instance of the picker acts normally
                                picker.get_selection_window = nil
                                return picked_window_id
                            end

                            return action_set.edit(prompt_bufnr, "edit")
                        end,
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--hidden",
                    "--glob=!**/.git/**",
                    "--glob=!**/node_modules/**",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
            },
            pickers = {
                find_files = {
                    -- find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
                    find_command = {
                        "rg",
                        "--files",
                        "--color=never",
                        "--hidden",
                        "--glob=!**/.git/**",
                        "--glob=!**/node_modules/**",
                    },
                    prompt_prefix = " ",
                    -- file_ignore_patterns = { "node_modules", "\\.git" },
                },
                --[[ lsp_dynamic_workspace_symbols = {
                    ignore_symbols = { "variable" },
                },
                lsp_document_symbols = {
                    ignore_symbols = { "variable" },
                }, ]]
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
        -- { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        -- { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Grep string under cursor" },
        { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
        { "<leader>fc", workspace_symbols_picker({ "class" }), desc = "Class" },
        { "<leader>fn", workspace_symbols_picker({ "function" }), desc = "Function" },
        -- { "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
        { "<leader>fd", "<cmd>Telescope aerial<cr>", desc = "Document symbols" },
        -- { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
        { "gR", "<cmd>Telescope lsp_references<cr>", desc = "References" },
        { "gD", "<cmd>Telescope lsp_definitions jump_type=never theme=cursor<cr>", desc = "Definitions" },
        {
            "<leader>fo",
            function()
                require("telescope.builtin").find_files({
                    find_command = {
                        "fd",
                        "--type",
                        "d",
                        "--hidden",
                        "--no-ignore",
                        "--exclude",
                        ".git",
                        "--exclude",
                        "node_modules",
                    },
                })
            end,
            desc = "Open directory in Oil",
        },
    },
}
