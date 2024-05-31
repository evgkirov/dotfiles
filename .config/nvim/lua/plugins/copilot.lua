return {
    "github/copilot.vim",
    cmd = { "Copilot" },
    -- event = "InsertEnter",
    config = function()
        vim.cmd("Copilot enable")
        vim.cmd([[
            imap <silent><script><expr> <M-CR> copilot#Accept("\<CR>")
            imap <silent> <C-j> <Plug>(copilot-next)
            imap <silent> <C-k> <Plug>(copilot-previous)
            " let g:copilot_no_tab_map = v:true
        ]])
    end,
}
