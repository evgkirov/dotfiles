return {
    opts = {
        enabled = true,
        convert = { notify = true },
        resolve = function(file, src)
            local ok, api = pcall(require, "obsidian.api")
            if ok and api.path_is_note(file) then
                local vault_root = tostring(Obsidian.dir)
                if vault_root then
                    local current_dir = vim.fn.fnamemodify(file, ":h")
                    while current_dir:find(vault_root, 1, true) == 1 do
                        local matches = vim.fn.glob(current_dir .. "/**/" .. src, false, true)
                        if #matches > 0 then
                            return matches[1]
                        end
                        local parent = vim.fn.fnamemodify(current_dir, ":h")
                        if parent == current_dir then
                            break
                        end
                        current_dir = parent
                    end
                end
            end
        end,
    },
}
