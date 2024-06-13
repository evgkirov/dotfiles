-- Default Copilot
-- return {
--     "github/copilot.vim",
--     cmd = { "Copilot" },
--     event = "InsertEnter",
--     config = function()
--         vim.cmd("Copilot enable")
--         vim.cmd([[
--             imap <silent><script><expr> <M-CR> copilot#Accept("\<CR>")
--             imap <silent> <C-j> <Plug>(copilot-next)
--             imap <silent> <C-k> <Plug>(copilot-previous)
--             " let g:copilot_no_tab_map = v:true
--         ]])
--     end,
-- }

-- Lua port
return {
    "zbirenbaum/copilot.lua",
    dependencies = { "zbirenbaum/copilot-cmp" },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        -- Recommended for copilot-cmp
        -- require("copilot").setup({
        --     suggestion = { enabled = false },
        --     panel = { enabled = false },
        -- })

        -- Ghost test and tab-suggestions
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<Tab>",
                    accept_word = false,
                    accept_line = "<S-Tab>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
        })
        require("copilot_cmp").setup({})
    end,
}
