return {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = {
        "rafamadriz/friendly-snippets",
        -- "giuxtaposition/blink-cmp-copilot",
    },

    -- use a release tag to download pre-built binaries
    version = "v0.*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = "cargo build --release",
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        keymap = { preset = "enter" },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, via `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            -- default = { "lsp", "path", "snippets", "buffer", "copilot" },

            -- completion = {
            --     enabled_providers = { "lsp", "path", "snippets", "buffer", "copilot" },
            -- },
            -- providers = {
            --     copilot = {
            --         name = "copilot",
            --         module = "blink-cmp-copilot",
            --     },
            -- },
        },
        completion = {
            list = {
                selection = "manual",
                -- selection = "auto_insert",
            },
            menu = {
                draw = {
                    -- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                if ctx.source_name == "copilot" then
                                    return "" .. ctx.icon_gap
                                end
                                return ctx.kind_icon .. ctx.icon_gap
                            end,
                            highlight = function(ctx)
                                if ctx.source_name == "copilot" then
                                    return "BlinkCmpKindSnippet"
                                end
                                return require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                                    or "BlinkCmpKind" .. ctx.kind
                            end,
                        },

                        kind = {
                            text = function(ctx)
                                if ctx.source_name == "copilot" then
                                    return "Copilot"
                                end
                                return ctx.kind
                            end,
                            highlight = function(ctx)
                                if ctx.source_name == "copilot" then
                                    return "BlinkCmpKindSnippet"
                                end
                                return require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                                    or "BlinkCmpKind" .. ctx.kind
                            end,
                        },
                    },
                },
            },
            documentation = {
                auto_show = true,
            },
        },

        -- experimental signature help support
        signature = { enabled = true },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
}
