return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        suggestion = {
            -- enabled = false, disable for blink-cmp-copilot
            enabled = true,
            auto_trigger = true,
            keymap = {
                accept = "<Tab>",
                prev = "<C-k>",
                next = "<C-j>",
            },
        },
        panel = {
            enabled = false,
        },
        filetypes = {
            yaml = true,
        },
    },
}
