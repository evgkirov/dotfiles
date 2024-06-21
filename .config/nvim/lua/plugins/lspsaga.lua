return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional
        "nvim-tree/nvim-web-devicons", -- optional
    },
    opts = {
        symbol_in_winbar = {
            enable = false,
        },
        lightbulb = {
            sign = false,
        },
        definition = {
            keys = {
                edit = "<CR>",
                vsplit = "<C-v>",
                split = "<C-h>",
                tabe = "<C-t>",
                quit = "q",
                -- quit = "Q",
                -- close = "q",
            },
        },
        finder = {
            keys = {
                toggle_or_open = "<CR>",
                vsplit = "<C-v>",
                split = "<C-h>",
                tabe = "<C-t>",
                quit = "q",
                -- quit = "Q",
                -- close = "q",
            },
        },
        diagnostic = {
            -- diagnostic_only_current = true,
            text_hl_follow = false,
            border_follow = false,
        },
        -- ui = {
        --     code_action = "󰌵",
        -- },
    },
    config = true,
    keys = {
        -- { "gd", ":Lspsaga peek_definition<CR>", desc = "Peek definition" },
        -- {
        --     "gd",
        --     function()
        --         vim.cmd("Lspsaga peek_definition")
        --
        --         vim.api.nvim_buf_set_keymap(
        --             0,
        --             "n",
        --             "<C-o>",
        --             "<cmd>lua require('nvim-window').pick()<CR>",
        --             { noremap = true, silent = true }
        --         )
        --     end,
        --     desc = "Peek definition",
        -- },
        -- { "gl", ":Lspsaga diagnostic_jump_next<CR>", desc = "Show diagnostics" },
        { "K", ":Lspsaga diagnostic_jump_next<CR>", desc = "Show diagnostics" },
        { "[d", ":Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic" },
        { "]d", ":Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" },
        -- { "gr", ":Lspsaga finder<CR>", desc = "Find references" },
    },
    init = function()
        vim.diagnostic.config({
            virtual_text = false,
        })
    end,
}
