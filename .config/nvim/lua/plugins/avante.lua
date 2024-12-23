-- vim.opt.laststatus = 3

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    -- version = false, -- set this if you want to always pull the latest change
    opts = {
        provider = "claude",
        auto_suggestions_provider = "claude",
        claude = {
            api_key_name = "cmd:cat " .. vim.fn.expand("~/.local/share/nvim/claude-api-key"),
        },
        openai = {
            api_key_name = "cmd:cat " .. vim.fn.expand("~/.local/share/nvim/openai-api-key"),
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
        mappings = {
            sidebar = {
                switch_windows = "<Hyper-hjkl>",
            },
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
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
}
