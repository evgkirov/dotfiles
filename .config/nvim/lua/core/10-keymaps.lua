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

wkc.s = { name = "󰝘 Splits..." }

opts.desc = "󰅗 Close window"
keymap("n", "<leader>sx", "<cmd>close<cr>", opts)

opts.desc = " Split horizontally"
keymap("n", "<leader>sh", "<cmd>belowright split<cr>", opts)

opts.desc = " Split vertically"
keymap("n", "<leader>sv", "<cmd>belowright vsplit<cr>", opts)

-- docker

wkc.d = { name = "󰡨 Docker..." }

keymap("n", "<leader>du", "<cmd>! docker compose up -d<cr>", {})
keymap("n", "<leader>dU", "<cmd>! docker compose up --build -d<cr>", {})
keymap("n", "<leader>dd", "<cmd>! docker compose down<cr>", {})

-- terminal

wkc.t = { name = " Terminal..." }

opts.desc = "New terminal"
keymap("n", "<leader>tt", "<cmd>terminal<cr>", opts)

opts.desc = "New terminal (horizonal split)"
keymap("n", "<leader>th", "<cmd>belowright split | terminal<cr>", opts)

opts.desc = "New terminal (vertical split)"
keymap("n", "<leader>tv", "<cmd>belowright vsplit | terminal<cr>", opts)
