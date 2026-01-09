local configs = require("plugins.snacks-configs")

local opts = { styles = {} }
local keys = {}

for name, config in pairs(configs) do
    if config.opts then
        opts[name] = config.opts
    end
    if config.styles then
        opts.styles[name] = config.styles
    end
    if config.keys then
        vim.list_extend(keys, config.keys)
    end
end

return {
    "folke/snacks.nvim",
    version = "*",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = opts,
    keys = keys,
}
