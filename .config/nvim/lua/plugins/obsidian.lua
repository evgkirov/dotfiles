return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/*.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Obsidian/*.md",
    },
    cmd = { "Obsidian" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Personal",
                path = "~/Obsidian/Personal",
            },
        },
        notes_subdir = "Inbox",
        daily_notes = {
            folder = "Areas/Daily Notes",
            date_format = "%Y/%Y-%m/%Y-%m-%d",
            template = "Daily Note Template",
            workdays_only = false,
        },
        templates = {
            folder = "Resources/Софт/Obsidian/Templates",
            substitutions = {
                ["date:dddd"] = function()
                    return os.date("%A")
                end,
            },
        },
        note_id_func = function(title)
            if not title then
                title = os.date("%H%M")
            end
            return os.date("%Y-%m-%d") .. " " .. title
        end,
        note_frontmatter_func = function(note)
            local existing_metadata = note.metadata or {}
            local default_metadata = {
                day = "[[" .. os.date("%Y-%m-%d") .. "]]",
                area = {},
                type = {},
                project = {},
                person = {},
            }
            local merged_metadata = vim.tbl_extend("force", default_metadata, existing_metadata)
            return merged_metadata
        end,
        completion = { -- disable: markdown-oxide handles this
            nvim_cmp = false,
            blink = false,
        },
        picker = {
            name = "telescope.nvim",
            note_mappings = {
                new = "<C-x>",
                insert_link = "<C-i>",
            },
            tag_mappings = {
                tag_note = "<C-x>",
                insert_tag = "<C-i>",
            },
        },
        ui = {
            enable = false,
        },
        use_advanced_uri = true,
        open_app_foreground = true,
        open_notes_in = vim.g.is_quick_notes and "current" or "vsplit",
        legacy_commands = false,
    },
    keys = {
        { "<leader>oa", ":Obsidian<cr>", desc = "Action..." },
        { "<leader>ox", ":Obsidian open<cr>", desc = "Open in Obsidian.app" },
        { "<leader>oo", ":Obsidian quick_switch<cr>", desc = "Quick Switch" },
        { "<leader>og", ":Obsidian search<cr>", desc = "Grep" },
        { "<leader>on", ":Obsidian new<cr>", desc = "New Note" },
        {
            "<leader>oq",
            function()
                local client = require("obsidian").get_client()
                local note = client:create_note({
                    title = os.date("%H%M") .. " Quick Note",
                    template = "Unique Note Template",
                    no_write = true,
                })
                client:open_note(note)
            end,
            desc = "New Quick Note",
        },
        { "<leader>od", ":Obsidian dailies<cr>", desc = "Today" },
        { "<leader>ot", ":Obsidian today<cr>", desc = "Today" },
        { "<leader>ob", ":Obsidian backlinks<cr>", desc = "Backlinks" },
        { "<leader>or", ":Obsidian rename<cr>", desc = "Rename" },
    },
}
