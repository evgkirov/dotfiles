require("helpers.which-key-config").o = { name = "󰇈 Obsidian..." }

local notes_glob = vim.fn.expand("~") .. "/Obsidian/**.md"
vim.cmd("autocmd BufNewFile,BufRead " .. notes_glob .. " set conceallevel=1")

return {
    "epwalsh/obsidian.nvim",
    -- version = "*", -- recommended, use latest release instead of latest commit
    event = {
        "BufReadPre " .. notes_glob,
        "BufNewFile " .. notes_glob,
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        notes_subdir = nil,
        templates = {
            subdir = "Resources/Софт/Obsidian/Templates",
            substitutions = {
                ["date:dddd"] = function()
                    return os.date("%A")
                end,
            },
        },
        daily_notes = {
            folder = "Areas/Daily Notes",
            date_format = "%Y/%Y-%m/%Y-%m-%d",
            template = "Daily Note Template.md",
        },
        note_id_func = function(title)
            local prefix = "Inbox/"
            if title ~= nil then
                return prefix .. title
            else
                return prefix .. os.date("%Y-%m-%d %H%M%S")
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
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
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
        attachments = {
            img_folder = "Inbox",
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
