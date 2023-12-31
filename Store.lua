local Store = {}

function Store.create(sceneGroup, buyCallback, AutoClickInitialCost)
    if type(AutoClickInitialCost) ~= "number" then
        error("AutoClickInitialCost must be a number")
    end

    local storeButton = display.newRect(display.contentCenterX, 325, 200, 50)
    storeButton:setFillColor(1, 0, 0)
    sceneGroup:insert(storeButton)
    storeButton:addEventListener("tap", buyCallback)

    local AutoClickCost = AutoClickInitialCost
    local AutoCickCostText = display.newText("Autoclick: $" .. AutoClickCost, display.contentCenterX, 325, native.systemFont, 20)
    sceneGroup:insert(AutoCickCostText)

    function Store.updateStoreButtonColor(canBuy)
        if canBuy then
            storeButton:setFillColor(0, 1, 0)
        else
            storeButton:setFillColor(1, 0, 0)
        end
    end

    function Store.updateCost(newCost)
        AutoClickCost = newCost
        AutoCickCostText.text = "Autoclick: $" .. AutoClickCost
    end
end

return Store
