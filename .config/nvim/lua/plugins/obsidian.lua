vim.api.nvim_create_user_command("ObsidianQuickNote", function()
    local title = os.date("%H%M") .. " Quick Note"
    require("obsidian").api.new_from_template(title, "Unique Note Template", function(note)
        note:open({ sync = true })
        vim.cmd("normal! Go")
        vim.cmd("normal! o")
        vim.cmd("startinsert")
    end)
end, {})

return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    cmd = { "Obsidian" },

    opts = {

        workspaces = {
            {
                name = "Personal",
                path = "~/Obsidian/Personal",
            },
        },

        notes_subdir = "Inbox",
        new_notes_location = "notes_subdir",

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

        frontmatter = {
            func = function(note)
                local existing_metadata = note.metadata or {}
                local default_metadata = {
                    day = "[[" .. os.date("%Y-%m-%d") .. "]]",
                    area = {},
                    type = "",
                    project = {},
                    person = {},
                }
                local merged_metadata = vim.tbl_extend("force", default_metadata, existing_metadata)
                return merged_metadata
            end,
        },

        completion = {
            nvim_cmp = false,
            blink = true,
            match_case = false,
            create_new = true,
        },

        legacy_commands = false,
        open = { use_advanced_uri = true },
        footer = { enabled = false },
        statusline = { enabled = false },
        ui = { enable = false },
    },
    -- init = function()
    --     vim.o.conceallevel = 2
    -- end,
    keys = {
        { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
        { "<leader>oa", "<cmd>Obsidian<cr>", desc = "Actions" },
        { "<leader>on", "<cmd>ObsidianQuickNote<cr>", desc = "New Note" },
        { "<leader>ox", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian.app" },
        { "<leader>od", ":Obsidian dailies<cr>", desc = "This week" },
        { "<leader>ot", ":Obsidian today<cr>", desc = "Today" },
        { "<leader>ob", ":Obsidian backlinks<cr>", desc = "Backlinks" },
    },
}
