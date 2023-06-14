local composer = require("composer")
local widget = require("widget")

local scene = composer.newScene()

local function onCharacterSelected(event)
    local character = event.target.character
    composer.gotoScene("escena1", {params = {character = character}})
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
    background:setFillColor(0.3, 0.6, 1)

    local title = display.newText(sceneGroup, "Selecciona un personaje", display.contentCenterX, 50, native.systemFontBold, 20)

    local character1Button = widget.newButton({
        label = "Personaje 1",
        x = display.contentCenterX,
        y = display.contentCenterY - 50,
        width = 200,
        height = 40,
        fontSize = 16,
        onRelease = onCharacterSelected
    })
    character1Button.character = "personaje1"

    local character2Button = widget.newButton({
        label = "Personaje 2",
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = 200,
        height = 40,
        fontSize = 16,
        onRelease = onCharacterSelected
    })
    character2Button.character = "personaje2"

    local character3Button = widget.newButton({
        label = "Personaje 3",
        x = display.contentCenterX,
        y = display.contentCenterY+50,
        width = 200,
        height = 40,
        fontSize = 16,
        onRelease = onCharacterSelected
    })
    character3Button.character = "personaje3"

    sceneGroup:insert(background)
    sceneGroup:insert(title)
    sceneGroup:insert(character1Button)
    sceneGroup:insert(character2Button)
    sceneGroup:insert(character3Button)
end

scene:addEventListener("create", scene)

return scene

