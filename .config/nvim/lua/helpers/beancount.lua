local M = {}

M.beancount_file = vim.fn.expand("~/Projects/finances/ledger/main.beancount")

local accounts_cache = nil
local payees_cache = nil

local function get_accounts()
    if accounts_cache then
        return accounts_cache
    end

    local cmd = 'uv run bean-query -f csv "'
        .. M.beancount_file
        .. '" "SELECT DISTINCT account WHERE close_date(account) is null ORDER BY account"'
    local handle = io.popen(cmd)
    if not handle then
        return {}
    end

    local result = handle:read("*a")
    handle:close()

    local accounts = {}
    for line in result:gmatch("[^\r\n]+") do
        -- Skip the CSV header line
        if line ~= "account" then
            table.insert(accounts, line)
        end
    end

    accounts_cache = accounts
    return accounts
end

local function get_payees()
    if payees_cache then
        return payees_cache
    end

    local cmd = 'uv run bean-query -f csv "'
        .. M.beancount_file
        .. '" "SELECT DISTINCT payee WHERE payee is not null ORDER BY payee"'
    local handle = io.popen(cmd)
    if not handle then
        return {}
    end

    local result = handle:read("*a")
    handle:close()

    local payees = {}
    for line in result:gmatch("[^\r\n]+") do
        -- Skip the CSV header line
        if line ~= "payee" then
            table.insert(payees, line)
        end
    end

    payees_cache = payees
    return payees
end

local function is_transaction_line()
    local line = vim.fn.getline(".")
    return line:match("^%d%d%d%d%-%d%d%-%d%d%s+[!*]") ~= nil
end

local function select_account()
    local accounts = get_accounts()

    vim.ui.select(accounts, {
        prompt = "Select account:",
    }, function(choice)
        if choice then
            vim.cmd('normal! 0f:"_ciW' .. choice)
        end
    end)
end

local function select_payee()
    local payees = get_payees()

    vim.ui.select(payees, {
        prompt = "Select payee:",
    }, function(choice)
        if choice then
            vim.cmd('normal! 0"_ci"' .. choice)
        end
    end)
end

function M.beancount_action()
    if is_transaction_line() then
        select_payee()
    else
        select_account()
    end
end

local function go_to_transaction_line()
    if is_transaction_line() then
        return true
    end

    local save_cursor = vim.fn.getpos(".")
    local pattern = "^\\d\\{4\\}-\\d\\{2\\}-\\d\\{2\\}\\s\\+[!*]"
    local found = vim.fn.search(pattern, "bW")

    if found == 0 then
        vim.fn.setpos(".", save_cursor)
        return false
    end

    return true
end

function M.toggle_transaction_flag()
    local save_cursor = vim.fn.getpos(".")

    if not go_to_transaction_line() then
        vim.notify("No transaction found", vim.log.levels.WARN)
        return
    end

    local line = vim.fn.getline(".")
    local new_line

    if line:match("^%d%d%d%d%-%d%d%-%d%d%s+!") then
        new_line = line:gsub("^(%d%d%d%d%-%d%d%-%d%d%s+)!", "%1*", 1)
    elseif line:match("^%d%d%d%d%-%d%d%-%d%d%s+%*") then
        new_line = line:gsub("^(%d%d%d%d%-%d%d%-%d%d%s+)%*", "%1!", 1)
    end

    vim.fn.setline(".", new_line)
    vim.fn.setpos(".", save_cursor)
end

return M
