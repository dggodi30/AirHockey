local Vector2 = require('Vec2')
Circle  = Class{}

function Circle:init(radius, vector)

    if type(radius) == 'number' and vector ~= nil and type(vector.x) == 'number' and type(vector.y) == 'number' then
        self.radius = radius
        self.center = vector
        --assert(not vector, "value0: " .. vector.x)
    else 
        self.radius = radius or 0
        self.center = Vec2(0, 0)
        --assert(not vector, "value1: " .. vector.x)
    end
end

function Circle:hits(circleA, normal)

    local vec = circleA.center:vectorSubtraction(self.center)
    if vec:length() <= self.radius + circleA.radius then
        normal = vec:normalize()
        circleA.center = self.center:vectorAddition(Vector2:multiply(normal, self.radius + circleA.radius))
        return normal
    end
    return normal
end

return Circle