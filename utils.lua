local json = require("json")
local utils = {}

function utils.save(money, AutoClickCost, AutoClickQtd)
    local saveData = {
        money = money,
        AutoClickCost = AutoClickCost,
        AutoClickQtd = AutoClickQtd
    }
    local saveDataString = json.encode(saveData)
    local path = system.pathForFile("save.json", system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        file:write(saveDataString)
        io.close(file)
    end
end

function utils.load()
    local path = system.pathForFile("save.json", system.DocumentsDirectory)
    local file = io.open(path, "r")
    if file then
        local saveDataString = file:read("*a")
        io.close(file)
        return json.decode(saveDataString)
    end
    return nil
end

return utils
