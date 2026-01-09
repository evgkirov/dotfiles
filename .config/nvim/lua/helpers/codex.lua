local cwd = vim.fn.getcwd()
if string.find(cwd, "/agvend") then
    return require("helpers.tool-in-terminal")("Codex", "codex resume")
else
    return require("helpers.tool-in-terminal")("Claude Code", "claude")
end
