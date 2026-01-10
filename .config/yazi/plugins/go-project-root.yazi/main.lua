--- @sync entry
local initial_cwd = nil

local function setup()
    initial_cwd = os.getenv("PWD")
end

local function entry()
    if initial_cwd then
        ya.emit("cd", { initial_cwd })
    end
end

return { setup = setup, entry = entry }
