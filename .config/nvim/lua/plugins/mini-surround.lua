return {
    "nvim-mini/mini.surround",
    version = "*",
    event = "VeryLazy",
    opts = {
        mappings = {
            add = "gsa", -- Add surrounding in Normal and Visual modes
            delete = "gsd", -- Delete surrounding
            find = "gsf", -- Find surrounding (to the right)
            find_left = "gsF", -- Find surrounding (to the left)
            highlight = "gsh", -- Highlight surrounding
            replace = "gsr", -- Replace surrounding

            suffix_last = "l", -- Suffix to search with "prev" method
            suffix_next = "n", -- Suffix to search with "next" method
        },
    },
}
