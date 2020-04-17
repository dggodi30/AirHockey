require 'Vec2'

Rectangle  = Class{}

function Rectangle:init(minPtx, minPty, maxPtx, maxPty)
    
    if type(minPtx) == 'number' and type(minPty) == 'number' and type(maxPtx) == 'number' and type(maxPty) == 'number' then
        self.minPt = Vec2(minPtx, minPty) 
        self.maxPt = Vec2(maxPtx, maxPty) 
    else
        self.minPt = Vec2()
        self.maxPt = Vec2()
    end
end

function Rectangle:forceInside(cir)
    
    local pos = cir.center
    local radius = cir.radius

    if pos.x - radius < self.minPt.x then
        pos.x = self.minPt.x + radius
    end

    if pos.x + radius > self.maxPt.x then
        pos.x = self.maxPt.x - radius
    end

    if pos.y - radius < self.minPt.y then      
        pos.y = self.minPt.y + radius
    end

    if pos.y + radius > self.maxPt.y then
        pos.y = self.maxPt.y - radius
    end
    cir.center = pos
    return cir
end

function Rectangle:isPtInside(pt)
    return pt.x >= self.minPt.x and pt.y >= self.minPt.y and pt.x <= self.maxPt.x and pt.y <= self.maxPt.y
end