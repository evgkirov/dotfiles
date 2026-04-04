vim.pack.add({
    { src = "https://github.com/catgoose/nvim-colorizer.lua" },
})

require("colorizer").setup({
    filetypes = { "*", "!beancount" },
    options = {
        parsers = {
            hex = {
                default = true,
                aarrggbb = true,
            },
            rgb = { enable = true },
            hsl = { enable = true },
            oklch = { enable = true },
        },
    },
})
