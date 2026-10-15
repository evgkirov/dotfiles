local M = {}

function M.add_comment_for_agent()
    -- Open a line above and type the FIXME marker; insert mode terminates
    -- automatically when `:normal` ends
    vim.cmd("normal! OFIXME(agents): ")

    -- Comment the line via the internals of the built-in `gcc`: set
    -- 'operatorfunc' + `g@_` (the `gcc` mapping is an expression mapping and
    -- cannot be triggered via `:normal` or `feedkeys`)
    vim.o.operatorfunc = "v:lua.require'vim._comment'.operator"
    vim.cmd("normal! g@_")

    -- Insert at end of line; fed as real input so insert mode persists
    vim.api.nvim_feedkeys("A", "n", false)
end

return M
