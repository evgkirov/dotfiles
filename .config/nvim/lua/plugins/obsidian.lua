require("helpers.which-key-config").o = { name = "󰇈 Obsidian..." }

return {
    "epwalsh/obsidian.nvim",
    -- version = "*", -- recommended, use latest release instead of latest commit
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Obsidian/**.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        notes_subdir = "Inbox",
        daily_notes = {
            folder = "Areas/Daily Notes",
            date_format = "%Y/%Y-%m/%Y-%m-%d",
            template = "Resources/Софт/Obsidian/Templates/Daily Note Template.md",
        },
        note_id_func = function(title)
            if title ~= nil then
                return title
            else
                return os.date("%Y-%m-%d %H%M%S")
            end
        end,
        -- disable_frontmatter = true,
        -- Optional, alternatively you can customize the frontmatter data.
        note_frontmatter_func = function(note)
            local out = {
                day = "[[" .. os.date("%Y-%m-%d") .. "]]",
                area = nil,
            }
            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end
            return out
        end,
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            vim.fn.jobstart({ "open", url }) -- Mac OS
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
        end,
        workspaces = {
            {
                name = "Personal",
                path = "~/Obsidian/Personal",
            },
        },
    },
    keys = {
        { "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick open" },
        { "<leader>og", "<cmd>ObsidianSearch<cr>", desc = "Grep" },
        {
            "<leader>on",
            function()
                vim.ui.input({
                    prompt = "Note name",
                    default = os.date("%Y-%m-%d %H%M"),
                }, function(title)
                    if title ~= nil then
                        vim.cmd({ cmd = "ObsidianNew", args = { title } })
                    end
                end)
            end,
            desc = "New note",
        },
        { "<leader>od", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
        { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Daily note" },
        { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Daily note (yesterday)" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
        { "<leader>o.", "<cmd>ObsidianOpen<cr>", desc = "Open in the app" },
    },
}
