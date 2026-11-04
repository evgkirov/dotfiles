vim.pack.add({
    { src = "https://github.com/milanglacier/minuet-ai.nvim", version = vim.version.range("*") },
})

-- https://github.com/milanglacier/minuet-ai.nvim#quick-start
require("minuet").setup({
    provider = "openai_fim_compatible",
    n_completions = 1, -- recommend for local model for resource saving
    -- I recommend beginning with a small context window size and incrementally
    -- expanding it, depending on your local computing power. A context window
    -- of 512, serves as an good starting point to estimate your computing
    -- power. Once you have a reliable estimate of your local computing power,
    -- you should adjust the context window to a larger value.
    context_window = 512,
    provider_options = {
        openai_fim_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:7b-base",
            -- model = "qwen2.5-coder:3b-base",
            optional = {
                max_tokens = 56,
                top_p = 0.9,
            },
        },
    },

    virtualtext = {
        auto_trigger_ft = { "*" },
        -- debounce = 400,
        keymap = {
            accept = "<S-Tab>",
            accept_line = "<Tab>",
            prev = "<C-p>",
            next = "<C-n>",
        },
    },
})
