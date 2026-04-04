vim.pack.add({
    { src = "https://github.com/stevearc/overseer.nvim", version = vim.version.range("*") },
})

require("overseer").setup()

vim.keymap.set("n", "<leader>rr", function()
    vim.cmd("OverseerOpen! bottom")
    vim.cmd("OverseerRun")
end, { desc = "Run task" })

vim.keymap.set("n", "<leader>rR", function()
    vim.cmd("OverseerOpen! bottom")
    vim.cmd("OverseerShell")
end, { desc = "Run shell" })

vim.keymap.set("n", "<leader>rt", "<cmd>OverseerToggle bottom<cr>", { desc = "Toggle Overseer" })
vim.keymap.set("n", "<leader>rs", "<cmd>OverseerQuickAction restart<cr>", { desc = "Restart Task" })
vim.keymap.set("n", "<leader>rf", "<cmd>OverseerQuickAction open float<cr>", { desc = "Open - Float" })
vim.keymap.set("n", "<leader>rq", "<cmd>OverseerQuickAction<cr>", { desc = "Quick Action (for current task)" })
vim.keymap.set("n", "<leader>ra", "<cmd>OverseerTaskAction<cr>", { desc = "Task Action (select task and run action)" })

vim.keymap.set("n", "<leader>du", function()
    vim.cmd("OverseerOpen! bottom")
    if vim.fn.filereadable("bin/dev-up.sh") == 1 then
        vim.cmd("OverseerShell ./bin/dev-up.sh --app -d")
    else
        vim.cmd("OverseerShell docker compose up -d")
    end
end, { desc = "docker compose up -d" })

vim.keymap.set("n", "<leader>dU", function()
    vim.cmd("OverseerOpen! bottom")
    if vim.fn.filereadable("bin/dev-up.sh") == 1 then
        vim.cmd("OverseerShell ./bin/dev-up.sh --app -d")
    else
        vim.cmd("OverseerShell docker compose up -d --build")
    end
end, { desc = "docker compose up -d --build" })

vim.keymap.set("n", "<leader>dd", function()
    vim.cmd("OverseerOpen! bottom")
    if vim.fn.filereadable("bin/dev-down.sh") == 1 then
        vim.cmd("OverseerShell ./bin/dev-down.sh")
    else
        vim.cmd("OverseerShell docker compose down")
    end
end, { desc = "docker compose down" })

vim.keymap.set("n", "<leader>dD", function()
    vim.cmd("OverseerOpen! bottom")
    local down_cmd = "docker compose down"
    local up_cmd = "docker compose up -d"

    if vim.fn.filereadable("bin/dev-down.sh") == 1 then
        down_cmd = "./bin/dev-down.sh"
    end

    if vim.fn.filereadable("bin/dev-up.sh") == 1 then
        up_cmd = "./bin/dev-up.sh --app -d"
    end

    vim.cmd("OverseerShell " .. down_cmd .. " && " .. up_cmd)
end, { desc = "docker compose down & up" })

vim.keymap.set("n", "<leader>deu", function()
    vim.cmd("OverseerOpen! bottom")
    vim.cmd("OverseerShell orbctl start")
end, { desc = "orbctl start" })

vim.keymap.set("n", "<leader>ded", function()
    vim.cmd("OverseerOpen! bottom")
    vim.cmd("OverseerShell orbctl stop")
end, { desc = "orbctl stop" })
