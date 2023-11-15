return {
    name = "docker compose down",
    builder = function(params)
        return {
            cmd = { "docker" },
            args = { "compose", "down" },
        }
    end,
    condition = {
        callback = function(search)
            return (vim.fn.filereadable(search.dir .. "docker-compose.yml") == 1)
        end,
    },
}

