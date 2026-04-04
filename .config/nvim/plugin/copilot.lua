vim.pack.add({
    "https://github.com/zbirenbaum/copilot.lua",
})

require("copilot").setup({
    suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
            accept = "<S-Tab>",
            accept_line = "<Tab>",
            prev = "<C-k>",
            next = "<C-j>",
        },
    },
    panel = {
        enabled = false,
    },
    filetypes = {
        yaml = true,
        markdown = true,
        beancount = true,
    },
})
