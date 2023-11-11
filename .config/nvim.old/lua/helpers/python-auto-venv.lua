local M = {}

local default_python = "/opt/homebrew/bin/python3"
local venvs_root = os.getenv("HOME") .. "/.local/share/python-envs"

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
local function isStringPresentInFile(filename, searchString)
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

local function executeCommand(command)
	local file = io.popen(command)
	local output = file:read("*a")
	file:close()
	return output
end

local function has_poetry()
	local has_pyproject = exists("pyproject.toml")
	if not has_pyproject then
		return false
	end
	return isStringPresentInFile("pyproject.toml", "%[tool%.poetry%]")
end

local function venv_path()
	local cwd = vim.fn.getcwd()
	local cwd_name = string.match(cwd, ".+/([^/]+)$")
	return venvs_root .. "/" .. cwd_name
end

function M.python_path()
	if has_poetry() then
		return executeCommand("poetry run which python")
	end
	return venv_path() .. "/bin/python"
end

local function pip_path()
	return venv_path() .. "/bin/pip"
end

function M.create_venv()
	local dir = venv_path()
	if has_poetry() then
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

function M.on_new_jedi_config(new_config)
	local use_venv = M.create_venv()
	if use_venv then
		new_config.init_options = {
			workspace = {
				environmentPath = M.python_path(),
			},
		}
	end
end

function M.create_pyright_config()
	if has_poetry() then
		os.execute(
			'jq --null-input --arg venv "$(basename $(poetry env info -p))" --arg venvPath "$(dirname $(poetry env info -p))" \'{ "venv": $venv, "venvPath": $venvPath }\' > pyrightconfig.json'
		)
	end
end
return M
