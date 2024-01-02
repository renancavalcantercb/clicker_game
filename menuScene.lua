local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local header = display.newText("Money Clicker", display.contentCenterX, 25, native.systemFont, 40)
    sceneGroup:insert(header)

    local startButton = display.newRect(display.contentCenterX, 150, 200, 100)

    startButton:setFillColor(0, 0, 1)
    sceneGroup:insert(startButton)

    local startButtonText = display.newText("Start", display.contentCenterX, 150, native.systemFont, 40)
    sceneGroup:insert(startButtonText)

    local optionsButton = display.newRect(display.contentCenterX, display.contentCenterY + 50, 200, 100)
    optionsButton:setFillColor(0, 0, 1)
    sceneGroup:insert(optionsButton)

    local optionsButtonText = display.newText("Options", display.contentCenterX, display.contentCenterY + 50, native.systemFont, 40)
    sceneGroup:insert(optionsButtonText)

    local footer = display.newText("by: CuTGuArDiAn Studios", display.contentCenterX, display.contentHeight - 75, native.systemFont, 24)
    sceneGroup:insert(footer)

    local function startGame()
        composer.gotoScene("gameScene")
    end

    local function goToOptions()
        composer.gotoScene("optionsScene")
    end

    startButton:addEventListener("tap", startGame)
    optionsButton:addEventListener("tap", goToOptions)
end

scene:addEventListener("create", scene)

return scene
