local function load_modules(name)
    -- Non-recursive module loader
    local path = vim.fn.stdpath("config") .. "/lua/" .. name
    local modules = {}
    for _, file in ipairs(vim.fn.readdir(path, [[v:val =~ '\.lua$']])) do
        table.insert(modules, require(name .. "." .. file:gsub("%.lua$", "")))
    end
    return modules
end

local function bootstrap_lazy()
    local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(path) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--branch=stable",
            "https://github.com/folke/lazy.nvim.git",
            path,
        })
    end
    vim.opt.rtp:prepend(path)
end

bootstrap_lazy()
load_modules("core")

require("lazy").setup(load_modules("plugins"), {
    defaults = {
        lazy = true,
    },
    ui = {
        border = "bold",
        backdrop = 100,
    },
})
