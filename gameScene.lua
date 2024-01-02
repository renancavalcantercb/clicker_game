local composer = require("composer")
local ButtonClass = require("ButtonClass")
local Store = require("Store")
local utils = require("utils")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local money = 0
    local moneyPerSecond = 0
    local moneyIncrement = 1
    local AutoClickCost = 50
    local AutoClickQtd = 0

    local moneyString = display.newText("Money: " .. utils.formatNumber(money), display.contentCenterX, 0, native.systemFont, 24)
    sceneGroup:insert(moneyString)

    local AutoClickQtdString = display.newText("Autoclickers: " .. AutoClickQtd, display.contentCenterX, 25, native.systemFont, 24)
    sceneGroup:insert(AutoClickQtdString)

    local moneyPerSecondString = display.newText("Money/s: " .. utils.formatNumber(moneyPerSecond), display.contentCenterX, 50, native.systemFont, 24)
    sceneGroup:insert(moneyPerSecondString)

    local function IncreaseScore(value)
        money = money + (value * moneyIncrement)
        moneyString.text = "Money: " .. utils.formatNumber(money)
        Store.updateStoreButtonColor(money >= AutoClickCost)
    end

    local activeTimers = {}

    local function ActivateAutoClicks(quantidade)
        for i, timerHandle in ipairs(activeTimers) do
            timer.cancel(timerHandle)
            activeTimers[i] = nil
        end

        activeTimers = {}

        for i = 1, quantidade do
            local newTimer = timer.performWithDelay(1000, function() IncreaseScore(1) end, 0)
            table.insert(activeTimers, newTimer)
        end
    end

    local loadedData = utils.load()
    if loadedData then
        money = loadedData.money
        AutoClickCost = loadedData.AutoClickCost
        AutoClickQtd = loadedData.AutoClickQtd or 0
        moneyIncrement = loadedData.moneyIncrement or 1
        moneyPerSecond = loadedData.moneyPerSecond or 0
        
        moneyString.text = "Money: " .. utils.formatNumber(money)
        AutoClickQtdString.text = "Autoclickers: " .. AutoClickQtd
        moneyPerSecondString.text = "Money/s: " .. utils.formatNumber(moneyPerSecond)
        ActivateAutoClicks(AutoClickQtd)
    end

    local function BuyAutoClicks()
        if money >= AutoClickCost then
            money = money - AutoClickCost
            moneyString.text = "Money: " .. utils.formatNumber(money)
            AutoClickCost = math.ceil(AutoClickCost * 1.23)
            AutoClickQtd = AutoClickQtd + 1

            moneyIncrement = moneyIncrement * 1.1

            moneyPerSecond = AutoClickQtd * moneyIncrement
            moneyPerSecondString.text = "Money/s: " .. utils.formatNumber(moneyPerSecond)

            AutoClickQtdString.text = "Autoclickers: " .. AutoClickQtd
            Store.updateCost(utils.formatNumber(AutoClickCost, 0))
            ActivateAutoClicks(AutoClickQtd)
            Store.updateStoreButtonColor(money >= AutoClickCost)
            utils.save(money, AutoClickCost, AutoClickQtd, moneyIncrement, moneyPerSecond)
        else
            print("Not enough money")
        end
    end

    local buttonOptions = {
        x = display.contentCenterX,
        y = 200,
        width = 75,
        height = 75,
        color = {0.5, 0.5, 1},
        value = 1,
        text = "Click!",
        tapAction = IncreaseScore
    }
    local button = ButtonClass.newButton(buttonOptions)
    sceneGroup:insert(button)

    Store.create(sceneGroup, BuyAutoClicks, AutoClickCost)

    local function saveGame()
        utils.save(money, AutoClickCost, AutoClickQtd, moneyIncrement, moneyPerSecond)
        local popup = display.newText("Game Saved!", display.contentCenterX, 425, native.systemFont, 16)
        sceneGroup:insert(popup)
        timer.performWithDelay(1000, function() popup:removeSelf() end)
    end

    timer.performWithDelay(60000, saveGame, 0)
end

scene:addEventListener("create", scene)

return scene
