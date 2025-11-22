local M = {}

M.on_save = function()
    return {
        tab_names = vim.g.TabbyTabNames or {},
    }
end

M.on_post_load = function(data)
    vim.g.TabbyTabNames = data.tab_names or {}
end

return M
