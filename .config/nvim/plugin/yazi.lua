vim.pack.add({
    { src = "https://github.com/mikavilpas/yazi.nvim", version = vim.version.range("*") },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

vim.g.loaded_netrwPlugin = 1

require("yazi").setup({
    open_for_directories = true,
    keymaps = {
        open_file_in_horizontal_split = "<c-s>",
        grep_in_directory = "<c-p>pap", -- pen pineapple apple pen
        open_and_pick_window = "<S-CR>",
    },
    hooks = {
        on_yazi_ready = function(buffer, config, process_api)
            vim.schedule(function()
                vim.api.nvim_buf_set_keymap(
                    buffer,
                    "t",
                    "<esc><esc>",
                    "<cmd>close<CR>",
                    { noremap = true, silent = true }
                )
                vim.api.nvim_create_autocmd("VimResized", {
                    buffer = buffer,
                    callback = function()
                        vim.cmd("cal cursor(0, 0)")
                    end,
                })
            end)
        end,
    },
})

vim.api.nvim_set_hl(0, "YaziFloatBorder", { link = "Grey" })

vim.keymap.set({ "n", "v" }, "-", "<cmd>Yazi<cr>", { desc = "File Explorer" })
vim.keymap.set("n", "_", "<cmd>Yazi cwd<cr>", { desc = "File Explorer (Project Root)" })
