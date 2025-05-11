return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
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
            if note.id == "Sticky Note" then
                return {}
            end
            local existing_metadata = note.metadata or {}
            local default_metadata = {
                day = "[[" .. os.date("%Y-%m-%d") .. "]]",
                area = "",
                type = "",
                project = "",
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
        open_notes_in = "vsplit",
    },
    keys = {
        { "<leader>oa", ":Obsidian<cr>", desc = "Action..." },
        { "<leader>ox", ":Obsidian open<cr>", desc = "Open in Obsidian.app" },
        { "<leader>oo", ":Obsidian quick_switch<cr>", desc = "Quick Switch" },
        { "<leader>og", ":Obsidian search<cr>", desc = "Grep" },
        { "<leader>on", ":Obsidian new<cr>", desc = "New Note" },
        { "<leader>od", ":Obsidian dailies<cr>", desc = "Today" },
        { "<leader>ot", ":Obsidian today<cr>", desc = "Today" },
        { "<leader>ob", ":Obsidian backlinks<cr>", desc = "Backlinks" },
    },
}
