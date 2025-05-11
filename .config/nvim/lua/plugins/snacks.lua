return {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
        image = {
            doc = {
                inline = false,
            },
            resolve = function(file, src)
                local obsidian_client = require("obsidian").get_client()
                local obsidian_root = obsidian_client:vault_root():fs_realpath()

                if string.sub(file, 1, #obsidian_root) == obsidian_root then
                    local new_image_path = obsidian_client:find_files(src)[1]
                    return new_image_path:resolve():fs_realpath()
                end
            end,
        },
    },
}
