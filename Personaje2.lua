local sheetOptions = {
    width = 100,
    height = 100,
    numFrames = 8,
    sheetContentWidth = 400,
    sheetContentHeight = 200
}

local sheet = graphics.newImageSheet("Personaje2.png", sheetOptions)

local sequences = {
    {
        name = "idle",
        start = 1,
        count = 2,
        time = 400,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "walkRight",
        start = 3,
        count = 4,
        time = 400,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "walkLeft",
        start = 7,
        count = 4,
        time = 400,
        loopCount = 0,
        loopDirection = "forward"
    }
}

local sprite = display.newSprite(sheet, sequences)
sprite.name = "personaje2"

return sprite
