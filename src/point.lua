Point  = Class{}

function Point:init(width, height)
    self.width = width or 0
    self.height = height or 0
end

return Point
