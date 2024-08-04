vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = { "*" },
    callback = function()
        os.execute("im-select org.unknown.keylayout.ENSR")
    end,
})
