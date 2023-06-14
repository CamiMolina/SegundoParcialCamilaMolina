local physics = require("physics")
physics.start()

local M = {}

M.gravityX = 0
M.gravityY = 9.8

M.setScale = function(scale)
    physics.setScale(scale)
end

M.setGravity = function(gravityX, gravityY)
    M.gravityX = gravityX
    M.gravityY = gravityY
    physics.setGravity(gravityX, gravityY)
end

M.addBody = function(object, bodyType, params)
    physics.addBody(object, bodyType, params)
end

return M
