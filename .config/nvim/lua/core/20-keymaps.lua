local keys = require("helpers.keymaps").keys

vim.o.langmap =
    "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

-- remove default mappings (0.11), I dont't like them

vim.keymap.del("n", "gra")
vim.keymap.del("v", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grt")

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

local function has_code_action()
    if vim.bo.buftype == "quickfix" then
        return false
    end

    local params = vim.lsp.util.make_range_params()
    local diagnostics = vim.diagnostic.get(0, { lnum = params.range.start.line })
    if diagnostics and #diagnostics > 0 then
        -- If there are diagnostics, we can assume that there are code actions available.
        -- This is a heuristic, but it speeds things up.
        return true
    end
    params.context = {
        diagnostics = diagnostics,
    }

    local responses = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 500)
    if not responses then
        return false
    end

    for _, response in pairs(responses) do
        if response.result and next(response.result) ~= nil then
            return true
        end
    end

    return false
end

keys({
    { "<leader>ca", mode = { "n", "v" }, vim.lsp.buf.code_action, desc = "Code action" },
    {
        "<cr>",
        mode = { "n", "v" },
        function()
            if has_code_action() then
                vim.schedule(vim.lsp.buf.code_action)
                return
            end

            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), "n", true)
        end,
        expr = true,
        desc = "Code action",
    },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
})

-- tabs

keys({
    { "<leader>tx", "<cmd>tabclose<cr>", desc = "󰅗 Close tab" },
    { "<leader>tn", "<cmd>tabnew<cr>", desc = "󰐕 New tab" },
})

-- terminal

keys({
    { "<leader>nn", "<cmd>terminal<cr>", desc = "New terminal" },
    { "<leader>nh", "<cmd>aboveleft vsplit | terminal<cr>", desc = "New terminal (west)" },
    { "<leader>nj", "<cmd>belowright split | terminal<cr>", desc = "New terminal (south)" },
    { "<leader>nk", "<cmd>aboveleft split | terminal<cr>", desc = "New terminal (north)" },
    { "<leader>nl", "<cmd>belowright vsplit | terminal<cr>", desc = "New terminal (east)" },
})
