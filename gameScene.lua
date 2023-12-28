local composer = require("composer")
local ButtonClass = require("ButtonClass")
local Store = require("Store")
local utils = require("utils")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local money = 0
    local AutoClickCost = 50
    local AutoClickQtd = 0

    local moneyString = display.newText("Money: " .. money, display.contentCenterX, 100, native.systemFont, 40)
    sceneGroup:insert(moneyString)

    local AutoClickQtdString = display.newText("Autocliques: " .. AutoClickQtd, display.contentCenterX, 150, native.systemFont, 24)
    sceneGroup:insert(AutoClickQtdString)

    local function IncreaseScore(value)
        money = money + value
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
        print(loadedData)
        money = loadedData.money
        AutoClickCost = loadedData.AutoClickCost
        AutoClickQtd = loadedData.AutoClickQtd or 0
        moneyString.text = "Money: " .. money
        AutoClickQtdString.text = "Autocliques: " .. AutoClickQtd
        ActivateAutoClicks(AutoClickQtd)
    end



    local function BuyAutoClicks()
        if money >= AutoClickCost then
            money = money - AutoClickCost
            moneyString.text = "Money: " .. money
            AutoClickCost = math.ceil(AutoClickCost * 1.15)
            AutoClickQtd = AutoClickQtd + 1
            AutoClickQtdString.text = "Autocliques: " .. AutoClickQtd
            Store.updateCost(AutoClickCost)
            ActivateAutoClicks(AutoClickQtd)
            Store.updateStoreButtonColor(money >= AutoClickCost)
            utils.save(money, AutoClickCost, AutoClickQtd)
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
        tapAction = IncreaseScore
    }
    local button = ButtonClass.newButton(buttonOptions)
    sceneGroup:insert(button)

    Store.create(sceneGroup, BuyAutoClicks, AutoClickCost)
end

scene:addEventListener("create", scene)

return scene
