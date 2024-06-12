return {
    "rmagatti/auto-session",
    dependencies = {
        "nvim-tree/nvim-tree.lua", -- so it can restore it
    },
    lazy = false,
    priority = 800,
    config = true,
    opts = {
        pre_save_cmds = { "NvimTreeClose" },
        save_extra_cmds = {
            "NvimTreeOpen",
        },
        post_restore_cmds = {
            "NvimTreeOpen",
        },
    },
}
