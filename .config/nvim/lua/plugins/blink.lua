return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        keymap = { preset = "enter" },

        appearance = {
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                cmdline = {
                    -- https://cmp.saghen.dev/modes/cmdline.html#enter-keymap
                    min_keyword_length = function(ctx)
                        -- when typing a command, only show when the keyword is 3 characters or longer
                        if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                            return 3
                        end
                        return 0
                    end,
                },
            },
        },

        completion = {
            accept = {
                auto_brackets = {
                    enabled = false,
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 50,
            },
            list = {
                selection = { preselect = false, auto_insert = true },
            },
        },

        signature = {
            enabled = true,
        },

        cmdline = {
            keymap = {
                preset = "enter",
                ["<Tab>"] = { "accept" },
                ["<CR>"] = { "accept_and_enter", "fallback" },
            },
            completion = {
                menu = {
                    auto_show = true,
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
