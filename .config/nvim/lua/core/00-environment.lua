-- Inspired by: https://linkarzu.com/posts/neovim/skitty-notes/#configure-neovim-with-neovim_modeskitty

-- possible values: default, quick_notes
local neovim_mode = vim.env.NEOVIM_MODE or "default"

vim.g.is_default_mode = neovim_mode == "default"
vim.g.is_quick_notes_mode = neovim_mode == "quick_notes"
