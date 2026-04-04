vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("blink-cmp").setup({
    keymap = { preset = "enter" },
    appearance = { nerd_font_variant = "mono" },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            -- https://cmp.saghen.dev/modes/cmdline.html#enter-keymap
            cmdline = {
                min_keyword_length = function(ctx)
                    if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                        return 3
                    end
                    return 0
                end,
            },
        },
    },
    completion = {
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 50 },
        list = { selection = { preselect = false, auto_insert = true } },
    },
    signature = { enabled = true },
    cmdline = {
        keymap = {
            preset = "enter",
            ["<Tab>"] = { "accept" },
            ["<CR>"] = { "accept_and_enter", "fallback" },
        },
        completion = { menu = { auto_show = true } },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})
