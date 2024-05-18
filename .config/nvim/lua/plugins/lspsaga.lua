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
        finder = {
            keys = {
                toggle_or_open = "<CR>",
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
        { "gd", ":Lspsaga peek_definition<CR>", desc = "Peek definition" },
        -- { "gl", ":Lspsaga diagnostic_jump_next<CR>", desc = "Show diagnostics" },
        { "K", ":Lspsaga diagnostic_jump_next<CR>", desc = "Show diagnostics" },
        { "[d", ":Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic" },
        { "]d", ":Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" },
        { "<space>cu", ":Lspsaga finder<CR>", desc = "Usages" },
    },
    init = function()
        vim.diagnostic.config({
            virtual_text = false,
        })
    end,
}
