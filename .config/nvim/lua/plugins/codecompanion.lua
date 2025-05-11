local function read_secret(uri)
    local handle = io.popen("op read '" .. uri .. "' --no-newline")
    if handle == nil then
        vim.notify("Failed to run command to retrieve " .. uri, vim.log.levels.ERROR)
        return nil
    end
    local api_key = handle:read("*a")
    handle:close()
    return api_key
end

return {
    "olimorris/codecompanion.nvim",
    version = "*",
    config = function()
        require("codecompanion").setup({
            adapters = {
                openai = function()
                    return require("codecompanion.adapters").extend("openai", {
                        env = {
                            api_key = read_secret("op://Private/OpenAI API KEY/credential"),
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
                diff = {
                    close_chat_at = 1000000,
                },
                chat = {
                    -- start_in_insert_mode = true,
                    -- show_settings = true,
                    window = {
                        layout = "float",
                    },
                },
            },
        })

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
        { "<leader>cc", ":CodeCompanionChat<CR>o", desc = "Code Companion Chat New", mode = { "n", "v" } },
        { "<leader>ct", ":CodeCompanionChat Toggle<CR>", desc = "Code Companion Chat Toggle", mode = { "n", "v" } },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}
