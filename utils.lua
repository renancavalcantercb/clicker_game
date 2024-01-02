local json = require("json")
local utils = {}

function utils.save(money, AutoClickCost, AutoClickQtd, moneyIncrement, moneyPerSecond)
    local saveData = {
        money = money,
        AutoClickCost = AutoClickCost,
        AutoClickQtd = AutoClickQtd,
        moneyIncrement = moneyIncrement,
        moneyPerSecond = moneyPerSecond
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

function utils.formatNumber(value, decimalPlaces)
    decimalPlaces = decimalPlaces or 2

    local formatString = "%0." .. decimalPlaces .. "f"
    local formattedValue = string.format(formatString, value)

    local integerPart, decimalPart = string.match(formattedValue, "(%d+)%.(%d*)")

    if not integerPart then
        integerPart = formattedValue
    end

    local formattedIntegerPart = string.gsub(integerPart, "^(-?%d+)(%d%d%d)", '%1,%2')

    if decimalPlaces > 0 and decimalPart then
        formattedValue = formattedIntegerPart .. "." .. decimalPart
    else
        formattedValue = formattedIntegerPart
    end

    return formattedValue
end


return utils
