return function(name, cmd)
    local Terminal = require("toggleterm.terminal").Terminal
    return Terminal:new({
        cmd = cmd,
        name = name,
        hidden = true,
        direction = "float",
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
    })
end
