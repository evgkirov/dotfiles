return function(name, cmd)
    local Terminal = require("toggleterm.terminal").Terminal
    return Terminal:new({
        cmd = cmd,
        name = name,
        display_name = name,
        hidden = true,
        direction = "float",
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "t",
                "<leader>x",
                "<cmd>close<CR>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_create_autocmd("VimResized", {
                buffer = term.bufnr,
                callback = function()
                    vim.cmd("cal cursor(0, 0)")
                end,
            })
        end,
    })
end
