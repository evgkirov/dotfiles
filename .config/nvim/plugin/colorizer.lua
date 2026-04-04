vim.pack.add({
    { src = "https://github.com/catgoose/nvim-colorizer.lua" },
})

require("colorizer").setup({
    filetypes = { "*" },
    options = {
        parsers = {
            hex = {
                enable = true,
                aarrggbb = true,
            },
        },
    },
})
