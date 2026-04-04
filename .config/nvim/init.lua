local function load_modules(name)
    -- Non-recursive module loader
    local path = vim.fn.stdpath("config") .. "/lua/" .. name
    local modules = {}
    for _, file in ipairs(vim.fn.readdir(path, [[v:val =~ '\.lua$']])) do
        table.insert(modules, require(name .. "." .. file:gsub("%.lua$", "")))
    end
    return modules
end

load_modules("core")
