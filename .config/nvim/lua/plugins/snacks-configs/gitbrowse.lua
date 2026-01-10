return {
    opts = {
        enabled = true,
    },
    keys = {
        {
            "<leader>gh",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse (Current File)",
            mode = { "n", "v" },
        },
        {
            "<leader>gH",
            function()
                Snacks.gitbrowse({ what = "repo" })
            end,
            desc = "Git Browse (Repo)",
        },
    },
}
