-- Inspired by: https://linkarzu.com/posts/neovim/skitty-notes/#configure-neovim-with-neovim_modeskitty
-- I use WezTerm for these purposes, but the feature is still called "skitty"

vim.g.neovim_mode = vim.env.NEOVIM_MODE or "default"
-- possible values: default, skitty
vim.g.is_default = vim.g.neovim_mode == "default"
vim.g.is_skitty = vim.g.neovim_mode == "skitty"
