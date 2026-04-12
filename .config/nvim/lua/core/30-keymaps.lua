vim.o.langmap =
    "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

-- remove default mappings (0.11), I dont't like them

vim.keymap.del("n", "gra")
vim.keymap.del("v", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "grx")

-- editors

local function close_snacks_picker()
    if vim.w.snacks_picker_preview then
        local Snacks = require("snacks")
        local pickers = Snacks.picker.get()
        local picker = pickers[1]
        if picker then
            Snacks.picker.actions.cancel(picker)
            return true
        end
    end
    return false
end

vim.keymap.set("n", "<leader>w", "<cmd>:wa<cr>", { silent = true, desc = "󰆔 Write all" })
vim.keymap.set("n", "<leader>W", "<cmd>:w<cr>", { silent = true, desc = "󰆓 Write one" })
vim.keymap.set("n", "<leader>q", "<cmd>:qa<cr>", { silent = true, desc = "󰩈 Quit" })

vim.keymap.set("n", "<leader>x", function()
    if not close_snacks_picker() then
        vim.cmd("close")
    end
end, { silent = true, desc = "󰅗 Close window" })

vim.keymap.set("n", "<leader>X", "<cmd>bufdo bd<cr>", { silent = true, desc = "󰱝 Clear context" })

vim.keymap.set("n", "<esc>", function()
    close_snacks_picker()
    -- vim.cmd("noh")
end, { silent = true, desc = "Cancel Snacks picker" })

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

vim.keymap.set({ "n", "v" }, "<cr>", function()
    if vim.bo.filetype == "beancount" then
        vim.schedule(require("helpers.beancount").beancount_action)
        return
    end

    if has_code_action() then
        vim.schedule(vim.lsp.buf.code_action)
        return
    end

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), "n", true)
end, { silent = true, expr = true, desc = "Code action" })

vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { silent = true, desc = "Rename" })

vim.keymap.set("n", "<S-CR>", function()
    if vim.bo.filetype == "beancount" then
        require("helpers.beancount").toggle_transaction_flag()
    elseif vim.bo.filetype == "markdown" then
        require("helpers.markdown").toggle_checkbox()
    end
end, { silent = true, desc = "Toggle Markdown checkbox / Beancount flag" })

vim.keymap.set("n", "<leader>cl", 'viW"cc<C-r>=<C-r>c<cr><esc>', { silent = true, desc = "Calculate" })
vim.keymap.set("v", "<leader>cl", '"cc<C-r>=<C-r>c<cr><esc>', { silent = true, desc = "Calculate" })

-- tabs

vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", { silent = true, desc = "󰅗 Close tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { silent = true, desc = "󰐕 New tab" })

-- splits

vim.keymap.set("n", "<leader>ss", "<cmd>split<cr>", { silent = true, desc = "Default Split Horizontally" })
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", { silent = true, desc = "Default Split Vertically" })
vim.keymap.set("n", "<leader>sh", "<cmd>aboveleft vsplit<cr>", { silent = true, desc = "Split to West" })
vim.keymap.set("n", "<leader>sj", "<cmd>belowright split<cr>", { silent = true, desc = "Split to South" })
vim.keymap.set("n", "<leader>sk", "<cmd>aboveleft split<cr>", { silent = true, desc = "Split to North" })
vim.keymap.set("n", "<leader>sl", "<cmd>belowright vsplit<cr>", { silent = true, desc = "Split to East" })
vim.keymap.set("n", "<leader>sH", "<cmd>topleft vsplit<cr>", { silent = true, desc = "Split to Far West" })
vim.keymap.set("n", "<leader>sJ", "<cmd>botright split<cr>", { silent = true, desc = "Split to Far South" })
vim.keymap.set("n", "<leader>sK", "<cmd>topleft split<cr>", { silent = true, desc = "Split to Far North" })
vim.keymap.set("n", "<leader>sL", "<cmd>botright vsplit<cr>", { silent = true, desc = "Split to Far East" })
