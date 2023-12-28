local Store = {}

function Store.create(sceneGroup, buyCallback, AutoClickInitialCost)
    if type(AutoClickInitialCost) ~= "number" then
        error("AutoClickInitialCost must be a number")
    end

    local storeButton = display.newRect(display.contentCenterX, 500, 200, 100)
    storeButton:setFillColor(1, 0, 0)
    sceneGroup:insert(storeButton)
    storeButton:addEventListener("tap", buyCallback)

    local AutoClickCost = AutoClickInitialCost
    local AutoCickCostText = display.newText("Autoclick: $" .. AutoClickCost, display.contentCenterX, 500, native.systemFont, 24)
    sceneGroup:insert(AutoCickCostText)

    function Store.updateStoreButtonColor(podeComprar)
        if podeComprar then
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
