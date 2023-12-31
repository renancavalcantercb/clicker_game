local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local header = display.newText("Money Clicker", display.contentCenterX, 25, native.systemFont, 40)
    sceneGroup:insert(header)

    local resetButton = display.newRect(display.contentCenterX, 150, 200, 100)
    resetButton:setFillColor(0, 0, 1)
    sceneGroup:insert(resetButton)

    local resetButtonText = display.newText("Reset", display.contentCenterX, 150, native.systemFont, 40)
    sceneGroup:insert(resetButtonText)

    local backButton = display.newRect(display.contentCenterX, display.contentCenterY + 50, 200, 100)
    backButton:setFillColor(0, 0, 1)
    sceneGroup:insert(backButton)

    local backButtonText = display.newText("Back", display.contentCenterX, display.contentCenterY + 50, native.systemFont, 40)
    sceneGroup:insert(backButtonText)

    local function goToMenu()
        composer.gotoScene("menuScene")
    end

    backButton:addEventListener("tap", goToMenu)

    local footer = display.newText("by: CuTGuArDiAn Studios", display.contentCenterX, display.contentHeight - 75, native.systemFont, 24)
    sceneGroup:insert(footer)

    local function resetGame()
        local alert = native.showAlert("Reset", "Are you sure you want to reset the game?", {"No", "Yes"}, function(event)
            if event.action == "clicked" and event.index == 2 then
                local utils = require("utils")
                utils.reset()
                native.showAlert("Reset", "Game reseted!", {"Ok"}, function(event)
                    if event.action == "clicked" then
                        composer.gotoScene("menuScene")
                    end
                end)
            end
        end)
    end

resetButton:addEventListener("tap", resetGame)
end

scene:addEventListener("create", scene)

return scene