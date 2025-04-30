return {
    "yetone/avante.nvim",
    version = false, -- Never set this value to "*"! Never!
    -- event = "VeryLazy",
    opts = {
        provider = "openai",
        auto_suggestions_provider = "openai",
        -- mode = "legacy", -- XXX
        claude = {
            api_key_name = "cmd:cat " .. vim.fn.expand("~/.local/share/nvim/claude-api-key"),
        },
        openai = {
            api_key_name = "cmd:cat " .. vim.fn.expand("~/.local/share/nvim/openai-api-key"),
            model = "gpt-4.1",
            -- disable_tools = true,
        },
        behaviour = {
            auto_suggestions = false,
        },
        hints = {
            enabled = false,
        },
        windows = {
            sidebar_header = {
                rounded = false,
            },
        },
        -- file_selector = {
        selector = {
            provider = "telescope",
        },
        mappings = {
            sidebar = {
                switch_windows = "<Hyper-hjkl>",
                reverse_switch_windows = "<Hyper-hjkl>",
                add_file = "o",
                remove_file = "dd",
            },
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        -- "zbirenbaum/copilot.lua", -- for providers='copilot'
        -- {
        --     -- support for image pasting
        --     "HakonHarnes/img-clip.nvim",
        --     event = "VeryLazy",
        --     opts = {
        --         -- recommended settings
        --         default = {
        --             embed_image_as_base64 = false,
        --             prompt_for_file_name = false,
        --             drag_and_drop = {
        --                 insert_mode = true,
        --             },
        --             -- required for Windows users
        --             use_absolute_path = true,
        --         },
        --     },
        -- },
    },
    keys = {
        { "<leader>aa", ":AvanteAsk<cr>", desc = "Ask", mode = { "n", "v" } },
        { "<leader>at", ":AvanteToggle<cr>", desc = "Toggle" },
        { "<leader>ae", ":AvanteEdit<cr>", desc = "Edit", mode = { "v" } },
    },
}
