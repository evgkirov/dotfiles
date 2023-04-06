vim.api.nvim_create_user_command("PythonCreateVenv", require("helpers.cmp-jedi-venv").create_venv, {})

vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "",
	command = "PythonCreateVenv",
})
