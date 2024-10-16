local keymap = vim.keymap.set
local opts = { silent = true }

-- editor

vim.o.langmap =
    "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

opts.desc = "󰆔 Write all"
keymap("n", "<leader>w", "<cmd>:wa<cr>", opts)

opts.desc = "󰆓 Write one"
keymap("n", "<leader>W", "<cmd>:w<cr>", opts)

opts.desc = "󰩈 Quit"
keymap("n", "<leader>q", "<cmd>:qa<cr>", opts)

opts.desc = "Hide search"
keymap("n", "<esc>", ":noh<CR>", opts)

opts.desc = "Break line and insert"
-- keymap("n", "<leader>o", "cib<cr><esc>O", opts)
keymap("n", "<leader>o", "i<cr><esc>O", opts)
keymap("v", "<leader>o", "c<cr><esc>O", opts)

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(args)
        opts.desc = nil
        vim.api.nvim_buf_set_keymap(args.buf, "i", "kj", "<esc>", opts)
        vim.api.nvim_buf_set_keymap(args.buf, "t", "kj", "<C-\\><C-n>", opts)
    end,
})

keymap("n", "[q", "<cmd>cprev<CR>", opts)
keymap("n", "]q", "<cmd>cnext<CR>", opts)

-- splits

-- wkc.s = { name = "󰝘 Splits..." }
--
-- opts.desc = "󰅗 Close window"
-- keymap("n", "<leader>sx", "<cmd>close<cr>", opts)
--
-- opts.desc = " Split horizontally"
-- keymap("n", "<leader>sh", "<cmd>belowright split<cr>", opts)
--
-- opts.desc = " Split vertically"
-- keymap("n", "<leader>sv", "<cmd>belowright vsplit<cr>", opts)

opts.desc = "󰅗 Close window"
keymap("n", "<leader>x", "<cmd>close<cr>", opts)

opts.desc = "󰱝 Clear context"
keymap("n", "<leader>X", "<cmd>bufdo bd<cr>", opts)

-- tabs

opts.desc = "󰅗 Close tab"
keymap("n", "<leader>tx", "<cmd>tabclose<cr>", opts)

opts.desc = "󰐕 New tab"
keymap("n", "<leader>tn", "<cmd>tabnew<cr>", opts)

opts.desc = "Tab 1"
keymap("n", "<leader>1", "1gt", opts)

opts.desc = "Tab 2"
keymap("n", "<leader>2", "2gt", opts)

opts.desc = "Tab 3"
keymap("n", "<leader>3", "3gt", opts)

opts.desc = "Tab 4"
keymap("n", "<leader>4", "4gt", opts)

opts.desc = "Tab 5"
keymap("n", "<leader>5", "5gt", opts)

opts.desc = "Tab 6"
keymap("n", "<leader>6", "6gt", opts)

opts.desc = "Tab 7"
keymap("n", "<leader>7", "7gt", opts)

opts.desc = "Tab 8"
keymap("n", "<leader>8", "8gt", opts)

opts.desc = "Tab 9"
keymap("n", "<leader>9", "9gt", opts)

-- terminal

opts.desc = "New terminal"
keymap("n", "<leader>nn", "<cmd>terminal<cr>", opts)

opts.desc = "New terminal (west)"
keymap("n", "<leader>nh", "<cmd>aboveleft vsplit | terminal<cr>", opts)

opts.desc = "New terminal (south)"
keymap("n", "<leader>nj", "<cmd>belowright split | terminal<cr>", opts)

opts.desc = "New terminal (north)"
keymap("n", "<leader>nk", "<cmd>aboveleft split | terminal<cr>", opts)

opts.desc = "New terminal (east)"
keymap("n", "<leader>nl", "<cmd>belowright vsplit | terminal<cr>", opts)
