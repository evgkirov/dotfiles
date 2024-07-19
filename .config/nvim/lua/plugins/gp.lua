return {
    "robitx/gp.nvim",
    config = true,
    opts = {
        toggle_target = "popup",
        openai_api_key = { "cat", vim.fn.expand("~/.local/share/nvim/openai-api-key") },
    },
    keys = {
        { "gpt", "<cmd>GpChatToggle<cr>", desc = "Open GPT chat" },
        { "gpt", ":GpChatPaste<cr>", mode = "v", desc = "Paste to GPT chat" },
        { "gpr", ":GpRewrite<cr>", mode = { "n", "v" }, desc = "GPT Rewrite" },
        { "gpa", ":GpAppend<cr>", mode = { "n", "v" }, desc = "GPT Append" },
        { "gpp", ":GpPrepend<cr>", mode = { "n", "v" }, desc = "GPT Prepend" },
    },
}
