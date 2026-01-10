local default_layout = "com.evgkirov.keyboardlayout.custom.keylayout.ENSR"
local saved_layout = nil

local function switch_layout(layout)
    vim.fn.jobstart("im-select " .. layout, {
        on_exit = function()
            vim.fn.jobstart("sh ~/.config/sketchybar/plugins/keyboard.sh")
        end,
    })
end

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = { "*" },
    callback = function()
        if saved_layout then
            switch_layout(saved_layout)
        end
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = { "*" },
    callback = function()
        vim.fn.jobstart("im-select", {
            stdout_buffered = true,
            on_stdout = function(_, data)
                if data and data[1] and data[1] ~= "" then
                    saved_layout = data[1]
                end
            end,
            on_exit = function()
                switch_layout(default_layout)
            end,
        })
    end,
})
