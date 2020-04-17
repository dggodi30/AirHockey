Sprite = Class{}

local Vector2 = require 'Vec2'

function Sprite:init(path, boundingCircle, pos, velocity)
    self.image = love.graphics.newImage(path)

    self.mBoundingCircle = boundingCircle
    self.mVec2Position = pos
    self.mVelocity = velocity  
end

function Sprite:width()
    return self.image:getPixelWidth()
end

function Sprite:height()
    return self.image:getPixelHeight()
end

function Sprite:update(dt)
    local results = self.mVelocity:multiply(self.mVelocity, dt) 
    self.mVec2Position = self.mVec2Position:addTo(results)

    self.mBoundingCircle.center = self.mVec2Position
end

function Sprite:render()
    local w = self:width()
    local h = self:height()

    local x = self.mVec2Position.x - (w/2)
    local y = self.mVec2Position.y - (h/2)

    love.graphics.draw(self.image, x, y)
end

return Sprite