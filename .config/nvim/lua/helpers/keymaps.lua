local M = {}

function M.keymap(mapping)
    local mode = mapping.mode or "n"
    local lhs = mapping[1]
    local rhs = mapping[2]
    local opts = { silent = true, desc = mapping.desc }

    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.keys(mappings)
    for _, mapping in ipairs(mappings) do
        M.keymap(mapping)
    end
end

return M
