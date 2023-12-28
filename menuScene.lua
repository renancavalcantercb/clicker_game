local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local header = display.newText("Money Clicker", display.contentCenterX, 100, native.systemFont, 40)
    sceneGroup:insert(header)


    local startButton = display.newRect(display.contentCenterX, display.contentCenterY, 200, 100)

    startButton:setFillColor(0, 0, 1)
    sceneGroup:insert(startButton)

    local startButtonText = display.newText("Start", display.contentCenterX, display.contentCenterY, native.systemFont, 40)
    sceneGroup:insert(startButtonText)

    local function iniciarJogo()
        composer.gotoScene("gameScene")
    end

    local footer = display.newText("by: CuTGuArDiAn Studios", display.contentCenterX, display.contentHeight - 100, native.systemFont, 24)
    sceneGroup:insert(footer)

    startButton:addEventListener("tap", iniciarJogo)
end

scene:addEventListener("create", scene)

return scene
