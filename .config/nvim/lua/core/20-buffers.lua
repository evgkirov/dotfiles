vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
        vim.cmd("bdelete!")
    end,
})

-- Enter insert mode when switching to terminal
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "",
    command = "startinsert",
})

-- Close terminal buffer on process exit
vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "term://*",
    command = "stopinsert",
})
