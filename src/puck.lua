Puck = Class{}

function Puck:init()
    self.image = love.graphics.newImage('puck.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
end

function Puck:render()
    love.graphics.draw(self.image, self.x, self.y)
end