vim.api.nvim_create_user_command("PythonCreateVenv", require("helpers.python-auto-venv").create_venv, {})

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	pattern = "",
-- 	command = "PythonCreateVenv",
-- })
