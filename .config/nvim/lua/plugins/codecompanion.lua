return {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    opts = {
        adapters = {
            openai = function()
                return require("codecompanion.adapters").extend("openai", {
                    env = {
                        api_key = "cmd:cat ~/.local/share/nvim/openai-api-key",
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
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}
