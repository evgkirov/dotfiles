return {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
        require("window-picker").setup({
            -- hint = "floating-big-letter",
            hint = "statusline-winbar",
            filter_rules = {
                autoselect_one = false,
                include_current_win = true,
            },
        })
    end,
}
