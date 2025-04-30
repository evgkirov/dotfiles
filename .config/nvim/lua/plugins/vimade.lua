return {
    "tadaa/vimade",
    version = "*",
    event = "UIEnter",
    opts = {
        blocklist = {
            only_behind_float_windows = function(win, current)
                -- current can be nil
                if (win.win_config.relative == "") and (current and current.win_config.relative ~= "") then
                    return false
                end
                return true
            end,
        },
        -- fadelevel = 0.6,
    },
}
