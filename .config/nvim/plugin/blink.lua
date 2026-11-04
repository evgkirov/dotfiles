vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("blink-cmp").setup({
    keymap = { preset = "enter" },
    appearance = { nerd_font_variant = "normal" },
    completion = {
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 50 },
        list = { selection = { preselect = false, auto_insert = true } },
        trigger = { prefetch_on_insert = false },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "minuet" },
        providers = {
            minuet = {
                name = "minuet",
                module = "minuet.blink",
                async = true,
                timeout_ms = 3000,
                score_offset = 50,
            },
        },
    },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})
