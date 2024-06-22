local M = {}

local venvs_root = os.getenv("HOME") .. "/.local/share/python-envs"
local poetry_lookup_paths = { "", "agbackend/" }

local function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

-- Function to check if a string is present in a file
local function is_string_presented_in_file(filename, searchString)
    if not exists(filename) then
        return false
    end
    -- Open the file in read mode
    local file = io.open(filename, "r")

    if file then
        -- Read the file contents
        local contents = file:read("*a")

        -- Check if the search string is present
        if contents:find(searchString) then
            return true
        end

        -- Close the file
        file:close()
    end

    return false
end

local function execute_command(command)
    local file = io.popen(command)
    local output = file:read("*a")
    file:close()
    return output
end

local function has_poetry(dir)
    return is_string_presented_in_file(dir .. "pyproject.toml", "%[tool%.poetry%]")
end

function M.venv_path()
    local cwd = vim.fn.getcwd()
    local cwd_name = string.match(cwd, ".+/([^/]+)$") or "NONE"
    return venvs_root .. "/" .. cwd_name
end

function M.python_path()
    for _, path in ipairs(poetry_lookup_paths) do
        if has_poetry(path) then
            return execute_command("poetry -C '" .. path .. "' run which python")
        end
    end
    return M.venv_path() .. "/bin/python"
end

local function pip_path()
    return M.venv_path() .. "/bin/pip"
end

function M.create_venv()
    local dir = M.venv_path()
    if has_poetry("") then
        return true
    end

    if not exists("requirements.txt") then
        return false
    end
    if exists(dir) then
        print("Using existing venv: " .. dir)
        return true
    end
    local input = vim.fn.input("Do you want to create venv and install packages? (y/N) : ")
    if input == "y" then
        print("Creating virtual environment...")
        os.execute("python3 -m venv '" .. dir .. "'")
        print("Installing packages...")
        os.execute(pip_path() .. " install -r requirements.txt 2>&1 | tee -a '" .. dir .. "/install_log.txt'")
        print("Created new venv: " .. dir)
        return true
    end
    return false
end

--[[ function M.create_pyright_config()
    if has_poetry() then
        os.execute(
            'jq --null-input --arg venv "$(basename $(poetry env info -p))" --arg venvPath "$(dirname $(poetry env info -p))" \'{ "venv": $venv, "venvPath": $venvPath }\' > pyrightconfig.json'
        )
    end
end ]]
return M
