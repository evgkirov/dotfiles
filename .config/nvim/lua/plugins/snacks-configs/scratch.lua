return {
    opts = {
        enabled = true,
        win = { backdrop = false },
    },
    styles = {
        wo = { winhighlight = "Normal:Normal,FloatBorder:Normal" },
        footer_keys = false,
    },
    keys = {
        {
            "<leader>b",
            function()
                Snacks.scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>B",
            function()
                Snacks.scratch.select()
            end,
            desc = "Select Scratch Buffer",
        },
    },
}
