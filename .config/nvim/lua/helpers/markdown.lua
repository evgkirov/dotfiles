local M = {}

local function is_checkbox_line()
    local line = vim.fn.getline(".")
    return line:match("%[.%]") ~= nil
end

function M.toggle_checkbox()
    if not is_checkbox_line() then
        return false
    end

    local line = vim.fn.getline(".")
    local new_line

    if line:match("%[ %]") then
        -- Empty checkbox -> checked
        new_line = line:gsub("%[ %]", "[x]", 1)
    else
        -- Any other checkbox (x, -, >, s, etc.) -> empty
        new_line = line:gsub("%[.%]", "[ ]", 1)
    end

    vim.fn.setline(".", new_line)
    return true
end

return M
