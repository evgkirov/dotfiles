return function(name, cmd)
    local Terminal = require("toggleterm.terminal").Terminal
    return Terminal:new({
        cmd = cmd,
        name = name,
        display_name = name,
        hidden = true,
        direction = "float",
        -- direction = "tab",
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_del_keymap(term.bufnr, "t", "kj")
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "t",
                "<leader>x",
                "<cmd>close<CR>",
                { noremap = true, silent = true }
            )
        end,
    })
end
