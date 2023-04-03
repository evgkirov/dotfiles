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

local function venv_path()
	local cwd = vim.fn.getcwd()
	local cwd_name = string.match(cwd, ".+/([^/]+)$")
	return venvs_root .. "/" .. cwd_name
end

local function python_path()
	return venv_path() .. "/bin/python"
end

local function pip_path()
	return venv_path() .. "/bin/pip"
end

function M.create_venv()
	local dir = venv_path()
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

function M.on_new_config(new_config)
	local use_venv = M.create_venv()
	if use_venv then
		new_config.init_options = {
			workspace = {
				environmentPath = python_path(),
			},
		}
	end
end

return M
