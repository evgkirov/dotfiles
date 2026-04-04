vim.pack.add({
    { src = "https://github.com/TaDaa/vimade", version = vim.version.range("*") },
})

require("vimade").setup({
    blocklist = {
        -- https://github.com/TaDaa/vimade/issues/82#issuecomment-2456158485
        only_behind_float_windows = function(win, current)
            -- current can be nil
            if (win.win_config.relative == "") and (current and current.win_config.relative ~= "") then
                return false
            end
            return true
        end,
    },
})
