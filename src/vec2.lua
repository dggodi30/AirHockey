Class = require 'class'
Vec2  = Class{}

function Vec2:init(vecx, vecy)

    if type(vecx) == 'number' and type(vecy) == 'number' then
        self.x = vecx
        self.y = vecy
    elseif not vecx == nil and type(vecx.x) == 'number' and type(vecx.y) == 'number' then
        self.x = vecx.x
        self.y = vecy.y
        assert(velocity == 'number', "value1: " .. self.x)
    else
        self.x = 0
        self.y = 0
    end
end



function Vec2:vectorAddition(v1) -- +
    local result = Vec2()
    result.x = self.x + v1.x
    result.y = self.y + v1.y
    return result
end

function Vec2:vectorSubtraction(v1) -- -
    local result = Vec2()
    result.x = self.x - v1.x
    result.y = self.y - v1.y
    return result
end

function Vec2:negateFromVector(v1) -- ~
    local result = Vec2()
    result.x = -v1.x
    result.y = -v1.y
    return result
end

function Vec2:addTo(v1) -- +=
    self.x = self.x + v1.x
    self.y = self.y + v1.y

    return self
end

function Vec2:subtractFrom(v1) -- +=
    self.x = self.x - v1.x
    self.y = self.y - v1.y
    return self
end

function Vec2:magnitude(scalar) -- *=
    self.x = self.x * scalar
    self.y = self.y * scalar
    return self
end

function Vec2:Divide(scalar) -- /=
    assert(scalar ~= 0, "Error divisor must not be 0!")
    self.x = self.x / scalar
    self.y = self.y / scalar
    return self
end

function Vec2:length()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vec2:normalize()
    local len = self:length()
    self.x = self.x / len
    self.y = self.y / len
    return self
end

function Vec2:dot(rhs) -- 0,0
    --assert(not rhs, "value: " .. rhs.x .. ", " .. rhs.y) -- 0,0
    return self.x * rhs.x + self.y * rhs.y
end

function Vec2:multiply(vec, scalar)
    local result = Vec2()
    result.x = vec.x * scalar
    result.y = vec.y * scalar
    return result
end

function Vec2:DivideFrom(vec, scalar)
    assert(scalar ~= 0, "Error divisor must not be 0!")
    local result = Vec2()
    result.x = vec.x / scalar
    result.y = vec.y / scalar
    return result
end

return Vec2