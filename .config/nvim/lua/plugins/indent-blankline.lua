return {
    "lukas-reineke/indent-blankline.nvim",
    version = "*",
    event = "BufEnter",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        scope = {
            show_end = false,
        },
    },
}
