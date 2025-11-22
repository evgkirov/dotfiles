return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    -- build = ":TSUpdate",
    build = {
        ":TSInstall all",
        ":TSUpdate",
    },
    init = function()
        local function ts_buf_enable(buf) end
        -- vim.api.nvim_create_autocmd("FileType", {  -- for some reason, doesn't work for buffers loaded by resession
        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function(args)
                local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
                if not ok or not parser then
                    return
                end
                pcall(vim.treesitter.start, args.buf)
                -- replicate `indent = { enable = true }`
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
