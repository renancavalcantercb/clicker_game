local composer = require("composer")
local ButtonClass = require("ButtonClass")
local Store = require("Store")
local utils = require("utils")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local money = 0
    local moneyIncrement = 1
    local AutoClickCost = 50
    local AutoClickQtd = 0

    local moneyString = display.newText("Money: " .. money, display.contentCenterX, 100, native.systemFont, 40)
    sceneGroup:insert(moneyString)

    local AutoClickQtdString = display.newText("Autoclickers: " .. AutoClickQtd, display.contentCenterX, 150, native.systemFont, 24)
    sceneGroup:insert(AutoClickQtdString)

    local function IncreaseScore(value)
        money = money + (value * moneyIncrement)
        moneyString.text = "Money: " .. money
        Store.updateStoreButtonColor(money >= AutoClickCost)
    end

    local function ActivateAutoClicks(quantidade)
        for i = 1, quantidade do
            timer.performWithDelay(1000, function() IncreaseScore(1) end, 0)
        end
    end

    local loadedData = utils.load()
    if loadedData then
        money = loadedData.money
        AutoClickCost = loadedData.AutoClickCost
        AutoClickQtd = loadedData.AutoClickQtd or 0
        moneyIncrement = loadedData.moneyIncrement or 1
        
        moneyString.text = "Money: " .. money
        AutoClickQtdString.text = "Autoclickers: " .. AutoClickQtd
        ActivateAutoClicks(AutoClickQtd)
    end



    local function BuyAutoClicks()
        if money >= AutoClickCost then
            money = money - AutoClickCost
            moneyString.text = "Money: " .. money
            AutoClickCost = math.ceil(AutoClickCost * 1.33)
            AutoClickQtd = AutoClickQtd + 1

            if AutoClickQtd % 10 == 0 then
                moneyIncrement = moneyIncrement + 1
            end

            AutoClickQtdString.text = "Autoclickers: " .. AutoClickQtd
            Store.updateCost(AutoClickCost)
            ActivateAutoClicks(AutoClickQtd)
            Store.updateStoreButtonColor(money >= AutoClickCost)
            utils.save(money, AutoClickCost, AutoClickQtd, moneyIncrement)
        else
            print("Not enough money")
        end
    end

    local buttonOptions = {
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = 50,
        height = 50,
        color = {0.5, 0.5, 1},
        value = 1,
        text = "Click!",
        tapAction = IncreaseScore
    }
    local button = ButtonClass.newButton(buttonOptions)
    sceneGroup:insert(button)

    Store.create(sceneGroup, BuyAutoClicks, AutoClickCost)
end

scene:addEventListener("create", scene)

return scene
