return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = "cd app && npm install && git reset --hard",
    init = function()
        -- vim.g.mkdp_auto_start = true
        vim.g.mkdp_auto_close = false
        vim.g.mkdp_open_to_the_world = false
        vim.g.mkdp_open_ip = "127.0.0.1"
        vim.g.mkdp_port = "8884"
        -- vim.g.mkdp_browser = "open"
        vim.g.mkdp_echo_preview_url = true
        vim.g.mkdp_page_title = "${name}"
    end,
    keys = {
        {
            "<leader>mp",
            "<cmd>MarkdownPreview<cr>",
            desc = " Start markdown preview",
        },
        {
            "<leader>ms",
            "<cmd>MarkdownPreviewStop<cr>",
            desc = " Stop markdown preview",
        },
    },
}
