vim.pack.add({
    {
        src = "https://github.com/folke/which-key.nvim",
        version = vim.version.range("*"),
    },
})

vim.o.timeout = true
vim.o.timeoutlen = 300

require("which-key").add({
    { "<leader>c", group = "Code..." },
    { "<leader>d", group = "Docker..." },
    { "<leader>de", group = "Docker Engine (OrbStack)..." },
    { "<leader>f", group = "Find..." },
    { "<leader>g", group = "Git..." },
    { "<leader>l", group = "Debug Prints..." },
    { "<leader>m", group = "Markdown..." },
    { "<leader>r", group = "Run..." },
    { "<leader>s", group = "Splits..." },
    { "<leader>t", group = "Tabs..." },
})

require("which-key").setup({
    icons = {
        breadcrumb = "",
        group = "",
        rules = false,
    },
})
