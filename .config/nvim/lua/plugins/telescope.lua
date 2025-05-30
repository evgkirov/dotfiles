local function workspace_symbols_picker(filter) -- luacheck: ignore
    return function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = filter,
        })
    end
end

local function action_open_in_window(direction, select_target, float)
    return function(prompt_bufnr)
        -- Use nvim-window-picker to choose the window by dynamically attaching a function
        local action_set = require("telescope.actions.set")
        local action_state = require("telescope.actions.state")
        local picker = action_state.get_current_picker(prompt_bufnr)

        picker.get_selection_window = function(picker, entry)
            local selected_window = require("helpers.opener").open_in_window(nil, direction, select_target, float)
            picker.get_selection_window = nil
            return selected_window
        end

        return action_set.edit(prompt_bufnr, "edit")
    end
end

return {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local themes = require("telescope.themes")

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
                    i = require("helpers.opener").create_mappings(action_open_in_window, {
                        ["<esc>"] = actions.close,
                        ["<C-t>"] = actions.select_tab,
                    }),
                    n = require("helpers.opener").create_mappings(action_open_in_window),
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
                        "--sortr=modified",
                        "--glob=!**/.git/**",
                        "--glob=!**/node_modules/**",
                    },
                    prompt_prefix = " ",
                    -- file_ignore_patterns = { "node_modules", "\\.git" },
                },
                lsp_definitions = {
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = {
                            preview_height = 0.9,
                        },
                    },
                    -- path_display = { "smart" },
                },
                lsp_references = {
                    layout_strategy = "vertical",
                    -- path_display = { "smart" },
                },
                lsp_dynamic_workspace_symbols = {
                    -- layout_strategy = "vertical",
                    -- path_display = { "smart" },
                },
                buffers = {
                    mappings = {
                        i = {
                            ["<C-x>"] = actions.delete_buffer,
                        },
                    },
                },
            },
            extensions = {
                aerial = {
                    -- show_columns = "symbols",
                    col2_width = 400,
                    -- Display symbols as <root>.<parent>.<symbol>
                    show_nesting = {
                        ["_"] = true, -- This key will be the default
                    },
                },
                smart_open = {
                    match_algorithm = "fzf",
                    result_limit = 100,
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
            },
        })
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
    end,
    keys = {
        { "<leader><space>", "<cmd>Telescope buffers sort_lastused=true<cr>", desc = "Buffers" },
        { "<F1>", "<cmd>Telescope help_tags<cr>", desc = "Help" },
        -- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
        { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        { "<leader>f*", "<cmd>Telescope grep_string<cr>", desc = "Grep string under cursor" },
        { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
        { "<leader>fc", workspace_symbols_picker({ "class" }), desc = "Class" },
        { "<leader>fn", workspace_symbols_picker({ "function" }), desc = "Function" },
        { "<leader>fd", "<cmd>Telescope aerial<cr>", desc = "Document symbols" },
        { "<leader>fD", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
        { "<leader>gf", "<cmd>Telescope git_status<cr>", desc = "Git Status (Telescope)" },
        { "<leader>gl", "<cmd>Telescope git_commits<cr>", desc = "Git Log" },
        { "<leader>gL", "<cmd>Telescope git_bcommits<cr>", desc = "Git Log (Current file)" },
        { "gd", "<cmd>Telescope lsp_definitions jump_type=never<cr>", desc = "View definition" },
        { "go", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definition" },
        { "gr", "<cmd>Telescope lsp_references<cr>", desc = "Find references" },
        { "<leader>cd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
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
