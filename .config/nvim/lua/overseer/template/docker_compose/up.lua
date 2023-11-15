return {
    name = "docker compose up",
    builder = function(params)
        return {
            cmd = { "docker" },
            args = { "compose", "up" },
        }
    end,
    condition = {
        callback = function(search)
            return (vim.fn.filereadable(search.dir .. "docker-compose.yml") == 1)
        end,
    },
}
