-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- load "core"
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/core", [[v:val =~ '\.lua$']])) do
    require("core." .. file:gsub("%.lua$", ""))
end

-- load "plugins"
require("lazy").setup("plugins", {
    defaults = {
        lazy = true,
    },
    ui = {
        border = "single",
    },
})
