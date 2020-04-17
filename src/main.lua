push = require 'util/push'

Class = require 'class'

local Vector2 = require 'Vec2'
require 'StateMachine'
require 'states/BaseState'
require 'states/TitleScreenState'
require 'states/PlayState'
require 'states/GameOverState'

local path = "assets/images/"

WINDOW_WIDTH = 1368 -- 1368
WINDOW_HEIGHT = 768 -- 768

-- size of game board
VIRTUAL_WIDTH = 864
VIRTUAL_HEIGHT = 504

local clientCenter = Vector2(VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2)-- 432, 252

local gameScale = {
    x = 1368 / 864,
    y = 768 / 504
}

local gimages = {}

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Hockey')

    smallFont = love.graphics.newFont('fonts/font.ttf', 12)
    mediumFont = love.graphics.newFont('fonts/flappy.ttf', 16)
    flappyFont = love.graphics.newFont('fonts/flappy.ttf', 28)
    love.graphics.setFont(flappyFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['gameover'] = function() return GameOverState() end,       
        ['play'] = function() return PlayState(clientCenter, gameScale) end
    }

    gStateMachine:change('title')

    love.keyboard.keysPressed = {}

    love.mouse.buttonsPressed = {}

    paused = false
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    
    love.keyboard.keysPressed[key] = true
    
    if key == 'escape' or key == 'q' then
        love.event.quit()
    end

    if key == 'p' then
        paused = not paused
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    if not paused then
        gStateMachine:update(dt)
        love.keyboard.keysPressed = {}
    end
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end