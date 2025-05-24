-- Shortcut for keymaps
local function map_select(keys, query_string, desc)
    return {
        keys,
        function()
            require("nvim-treesitter-textobjects.select").select_textobject(query_string, "textobjects")
        end,
        mode = { "x", "o" },
        desc = desc,
    }
end

return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    -- event = "BufEnter",
    enabled = false,
    opts = {
        select = {
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            -- selection_modes = {
            --     ["@function.outer"] = "V",
            --     ["@class.outer"] = "V",
            -- },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = false,
        },
    },
    keys = {
        map_select("af", "@function.outer", "TS function"),
        map_select("if", "@function.inner", "TS function"),
        map_select("ac", "@class.outer", "TS class"),
        map_select("ic", "@class.inner", "TS class"),
        map_select("al", "@loop.outer", "TS loop"),
        map_select("il", "@loop.inner", "TS loop"),
        map_select("ak", "@block.outer", "TS block"),
        map_select("ik", "@block.inner", "TS block"),
        map_select("aa", "@parameter.outer", "TS parameter"),
        map_select("ia", "@parameter.inner", "TS parameter"),
        map_select("=", "@assignment.rhs", "TS assignment value"),
    },
}
