local keys = require("helpers.keymaps").keys

vim.o.langmap =
    "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

-- remove default mappings (0.11), I dont't like them

vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")

-- editors

keys({
    { "<leader>w", "<cmd>:wa<cr>", desc = "󰆔 Write all" },
    { "<leader>W", "<cmd>:w<cr>", desc = "󰆓 Write one" },
    { "<leader>q", "<cmd>:qa<cr>", desc = "󰩈 Quit" },
    { "<leader>x", "<cmd>close<cr>", desc = "󰅗 Close window" },
    { "<leader>X", "<cmd>bufdo bd<cr>", desc = "󰱝 Clear context" },
    { "<esc>", ":noh<cr>", desc = "Hide search" },
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(args)
        vim.api.nvim_buf_set_keymap(args.buf, "i", "kj", "<esc>", { silent = true })
        vim.api.nvim_buf_set_keymap(args.buf, "t", "kj", "<C-\\><C-n>", { silent = true })
    end,
})

-- code

keys({
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
    { "?", vim.lsp.buf.code_action, desc = "Code action" },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
})

-- tabs

keys({
    { "<leader>tx", "<cmd>tabclose<cr>", desc = "󰅗 Close tab" },
    { "<leader>tn", "<cmd>tabnew<cr>", desc = "󰐕 New tab" },
    { "<leader>1", "1gt", desc = "Tab 1" },
    { "<leader>2", "2gt", desc = "Tab 2" },
    { "<leader>3", "3gt", desc = "Tab 3" },
    { "<leader>4", "4gt", desc = "Tab 4" },
    { "<leader>5", "5gt", desc = "Tab 5" },
    { "<leader>6", "6gt", desc = "Tab 6" },
    { "<leader>7", "7gt", desc = "Tab 7" },
    { "<leader>8", "8gt", desc = "Tab 8" },
    { "<leader>9", "9gt", desc = "Tab 9" },
})

-- terminal

keys({
    { "<leader>nn", "<cmd>terminal<cr>", desc = "New terminal" },
    { "<leader>nh", "<cmd>aboveleft vsplit | terminal<cr>", desc = "New terminal (west)" },
    { "<leader>nj", "<cmd>belowright split | terminal<cr>", desc = "New terminal (south)" },
    { "<leader>nk", "<cmd>aboveleft split | terminal<cr>", desc = "New terminal (north)" },
    { "<leader>nl", "<cmd>belowright vsplit | terminal<cr>", desc = "New terminal (east)" },
})
