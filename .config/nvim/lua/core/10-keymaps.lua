local wkc = require("helpers.which-key-config")
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

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(args)
        opts.desc = nil
        vim.api.nvim_buf_set_keymap(args.buf, "i", "jk", "<esc>", opts)
        vim.api.nvim_buf_set_keymap(args.buf, "t", "jk", "<C-\\><C-n>", opts)
    end,
})

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

-- tabs

wkc.t = { name = "󰓩 Tabs..." }

opts.desc = "Toggle tabline"
keymap("n", "<leader>tl", ":execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>", opts)

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

-- docker

-- wkc.d = { name = "󰡨 Docker..." }

-- keymap("n", "<leader>du", "<cmd>! docker compose up -d<cr>", {})
-- keymap("n", "<leader>dU", "<cmd>! docker compose up --build -d<cr>", {})
-- keymap("n", "<leader>dd", "<cmd>! docker compose down<cr>", {})

-- terminal

wkc.t = { name = " Terminal..." }

opts.desc = "New terminal"
keymap("n", "<leader>tt", "<cmd>terminal<cr>", opts)

opts.desc = "New terminal (horizonal split)"
keymap("n", "<leader>th", "<cmd>belowright split | terminal<cr>", opts)

opts.desc = "New terminal (vertical split)"
keymap("n", "<leader>tv", "<cmd>belowright vsplit | terminal<cr>", opts)
