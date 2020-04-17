GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    assert(true, "value: " .. params.blueScore .. ", " .. params.redScore)
    self.blueScore = params.blueScore or 0
    self.redScore = params.redScore or 0
    self.msg = ""
    self.color = self:setColor()
end

function GameOverState:update(dt)
    if self.blueScore > self.redScore then
        self.msg = "Blue Wins"
        self.color = self:setColor(0, 1, 0, 1)
    else
        self.msg = "Red Wins"
        self.color = self:setColor(1, 0, 0, 1)
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function GameOverState:setColor(r, g, b, a)
    local red = r or 1
    local blue = b or 1
    local green = g or 1
    local alpha = a or 1

    return {
        red = red, blue = blue, green = green, alpha = alpha
    }
end

function GameOverState:render(dt)
    love.graphics.setFont(flappyFont)
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)    
    love.graphics.setColor(self.color.red, self.color.blue, self.color.green, self.color.alpha)
    love.graphics.print(self.msg, VIRTUAL_WIDTH / 2 - 35, VIRTUAL_HEIGHT / 2)

    local playagainMsg = "Press Enter to Play Again!"
    love.graphics.setFont(smallFont)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(playagainMsg, 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')

    local quitMsg = "'Q' to quit"
    love.graphics.printf(quitMsg, 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
end