local ButtonClass = {}

function ButtonClass.newButton(options)
    local button = display.newCircle(options.x, options.y, options.width, options.height)
    button:setFillColor(options.color[1], options.color[2], options.color[3])
    button.value = options.value

    function button:tap(event)
        options.tapAction(self.value)
    end

    button:addEventListener("tap", button)

    return button
end

return ButtonClass
