AirHockeyGame  = Class{}

function AirHockeyGame:init()

    self.bc = "6"--center--Circle()

end

function AirHockeyGame:render()
    love.graphics.printf(self.bc.radius, 0, 64, VIRTUAL_WIDTH, 'center')
end

