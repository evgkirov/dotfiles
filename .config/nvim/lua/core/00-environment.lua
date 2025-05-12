-- Inspired by: https://linkarzu.com/posts/neovim/skitty-notes/#configure-neovim-with-neovim_modeskitty

vim.g.neovim_mode = vim.env.NEOVIM_MODE or "default"
-- possible values: default, quick_notes
vim.g.is_default = vim.g.neovim_mode == "default"
vim.g.is_quick_notes = vim.g.neovim_mode == "quick_notes"
