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
        -- vim.api.nvim_create_autocmd("VimEnter", {
        --     callback = function()
        --         vim.cmd.TSInstall("all")
        --         vim.cmd.TSUpdate()
        --     end,
        -- })
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
                if not ok or not parser then
                    return
                end
                pcall(vim.treesitter.start)
                -- vim.bo[args.buf].syntax = "on"
                vim.bo[args.buf].syntax = "off"
            end,
        })
    end,
}
