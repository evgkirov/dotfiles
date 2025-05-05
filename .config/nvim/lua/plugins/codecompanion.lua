return {
    "olimorris/codecompanion.nvim",
    version = "*",
    opts = {
        adapters = {
            openai = function()
                return require("codecompanion.adapters").extend("openai", {
                    env = {
                        api_key = "cmd:op read 'op://Private/OpenAI API KEY/credential' --no-newline",
                    },
                })
            end,
        },
        strategies = {
            chat = {
                adapter = "openai",
            },
            inline = {
                adapter = "openai",
            },
        },
        display = {
            chat = {
                start_in_insert_mode = true,
                show_settings = true,
                window = {
                    layout = "float",
                },
            },
        },
    },
    init = function()
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "CodeCompanionDiffAttached",
            callback = function(request)
                vim.cmd.stopinsert()
            end,
        })
    end,
    cmd = {
        "CodeCompanion",
        "CodeCompanionChat",
        "CodeCompanionActions",
        "CodeCompanionCmd",
    },
    keys = {
        { "<leader>ce", ":CodeCompanion<CR>", desc = "Code Companion Edit", mode = { "n", "v" } },
        { "<leader>cc", ":CodeCompanionChat<CR>", desc = "Code Companion Chat", mode = { "n", "v" } },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}
