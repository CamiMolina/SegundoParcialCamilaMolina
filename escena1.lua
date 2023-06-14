local composer = require("composer")
local physics = require("physics")

local scene = composer.newScene()

local personaje
local characterSheet
local sequenceData

local function moveCharacter(event)
    local phase = event.phase
    local character = event.target.character

    if phase == "down" then
        if event.keyName == "left" then
            personaje:setSequence("walkLeft")
            personaje:play()
            personaje.xScale = -1
            personaje:setLinearVelocity(-200, 0)
        elseif event.keyName == "right" then
            personaje:setSequence("walkRight")
            personaje:play()
            personaje.xScale = 1
            personaje:setLinearVelocity(200, 0)
        end
    elseif phase == "up" then
        if event.keyName == "left" or event.keyName == "right" then
            personaje:setSequence("idle")
            personaje:play()
            personaje:setLinearVelocity(0, 0)
        end
    end

    return true
end

local function jump(event)
    local phase = event.phase
    local character = event.target.character

    if phase == "up" and event.keyName == "space" then
        if personaje.numSaltos < 2 then
            personaje:applyLinearImpulse(0, -4, personaje.x, personaje.y)
            personaje.numSaltos = personaje.numSaltos + 1
        end
    end

    return true
end

local function collisionListener(event)
    local phase = event.phase
    local character = event.target.character

    if phase == "began" then
        if event.other.name == "floor" then
            personaje.numSaltos = 0
        elseif event.other.name == "obstacle" then
        end
    elseif phase == "ended" then
        if event.other.name == "obstacle" then
        end
    end
end

function scene:create(event)
    local sceneGroup = self.view

    physics.start()
    physics.setGravity(0, 20)

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
    background:setFillColor(0.6, 0.8, 1)

    local character = event.params.character

    characterSheet = graphics.newImageSheet("spritesheet.png", {
        width = 32,
        height = 32,
        numFrames = 12,
        sheetContentWidth = 96,
        sheetContentHeight = 128
    })

    sequenceData = {
        {name = "idle", frames = {1}},
        {name = "walkLeft", frames = {9, 10, 11, 12}, time = 400, loopCount = 0},
        {name = "walkRight", frames = {5, 6, 7, 8}, time = 400, loopCount = 0}
    }

    personaje = display.newSprite(sceneGroup, characterSheet, sequenceData)
    personaje.name = character
    personaje.x = display.contentCenterX
    personaje.y = display.contentHeight - 100
    personaje.numSaltos = 0

    physics.addBody(personaje, "dynamic", {bounce = 0, friction = 1})
    personaje:setSequence("idle")
    personaje:play()

    personaje:addEventListener("key", moveCharacter)
    personaje:addEventListener("key", jump)
    personaje:addEventListener("collision", collisionListener)

    local floor = display.newRect(sceneGroup, display.contentCenterX, display.contentHeight - 20, display.actualContentWidth, 40)
    floor:setFillColor(0.2, 0.4, 0.6)
    physics.addBody(floor, "static", {bounce = 0, friction = 1})
    floor.name = "floor"

    sceneGroup:insert(background)
    sceneGroup:insert(personaje)
    sceneGroup:insert(floor)
end

function scene:destroy(event)
    local sceneGroup = self.view

    physics.stop()

    if personaje then
        personaje:removeEventListener("key", moveCharacter)
        personaje:removeEventListener("key", jump)
        personaje:removeEventListener("collision", collisionListener)
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
