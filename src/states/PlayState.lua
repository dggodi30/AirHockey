PlayState = Class{__includes = BaseState}

require 'Sprite'
require 'Rectangle'

local Vector2 = require('Vec2')
local Circle = require ('Circle')
local Point = require('Point')

local MAX_PUCK_SPEED = 1000
local RED_SPEED = 500

local path = "assets/images/"

function PlayState:init(wndCenter, gameScale)
    self.gameScale = gameScale
    self.mWndCenterPt = wndCenter
    self.mblueScore = 0
    self.mredScore = 0
    self.mPaused = true
    self.mRedRecoverTime = 0.0

    self.mGameBoard = Sprite(path .. 'hockeyboard.png', Circle(), wndCenter, Vector2(0, 0))
    self.mPuck = Sprite(path .. 'puck.png', Circle(18, wndCenter), wndCenter, Vector2(0, 0))
    self.mRedPaddle = Sprite(path .. 'redPaddle.png', Circle(25.0, Vector2(700, 200)), Vector2(700, 200), Vector2(0, 0))   
    self.mBluePaddle = Sprite(path .. 'bluePaddle.png', Circle(25.0, Vector2(100, 100)), Vector2(100, 100), Vector2(0, 0))

    self.mLastMousePos = Vector2(100, 100) 

    self.mBlueBounds = Rectangle(20, 30, 432, 480)
    self.mRedbounds = Rectangle(432, 40, 854, 480)
    self.mBoardBounds = Rectangle(7, 40, 854, 480)
    self.mBlueGoal = Rectangle(0, 146, 30, 354)
    self.mRedGoal = Rectangle(833, 146, 863, 354)

    self.mPaused = true 
    self.mStart = true

end

function PlayState:pause()
    self.mPaused = true
    love.mouse.setVisible(true)
end

function PlayState:unpause()
    self.mPaused = false
    self.mStart = false
    love.mouse.setVisible(false)
    love.mouse.setPosition(self.mLastMousePos.x, self.mLastMousePos.y)
end

function PlayState:update(dt)
     
    --[[if self.mPaused then
        if love.keyboard.wasPressed('space') then
            self:unpause()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self:pause()
        return
    end]]

    if self.mPaused and self.mStart then
        self:unpause() 
        love.mouse.setPosition(self.mLastMousePos.x, self.mLastMousePos.y)
        self.mLastMousePos = Vector2(self.mLastMousePos.x, self.mLastMousePos.y)      
    else
        if self.mPaused == false then
            self:updateBluePaddle(dt)
            self:updateRedPaddle(dt)
            self:updatePuck(dt) 
        end
    end
end

function PlayState:updateBluePaddle(dt)

    local x, y = love.mouse.getPosition()
    local dx = x - self.mLastMousePos.x
    local dy = y - self.mLastMousePos.y

    self.mBluePaddle.mVelocity = Vector2:DivideFrom(Vector2(dx, dy), dt)
    self.mBluePaddle:update(dt)   

    self.mBlueBounds:forceInside(self.mBluePaddle.mBoundingCircle)
    self.mBluePaddle.mVec2Position = self.mBluePaddle.mBoundingCircle.center
    self.mLastMousePos = self.mBluePaddle.mVec2Position

    love.mouse.setPosition(self.mLastMousePos.x, self.mLastMousePos.y)
end

function PlayState:updateRedPaddle(dt)
    
    if self.mRedRecoverTime <= 0 then
        if self.mRedbounds:isPtInside(self.mPuck.mVec2Position) then
            local redVelocity = self.mPuck.mVec2Position:vectorSubtraction(self.mRedPaddle.mVec2Position)
            redVelocity:normalize()
            redVelocity:magnitude(RED_SPEED)
            self.mRedPaddle.mVelocity = redVelocity
        else
            local redVelocity = Vector2(700, 200)
            redVelocity:vectorSubtraction(self.mRedPaddle.mVec2Position)
            if redVelocity:length() > 5 then
                redVelocity:normalize()
                redVelocity:magnitude(RED_SPEED)
                self.mRedPaddle.mVelocity = redVelocity
            else
                self.mRedPaddle.mVelocity = Vector2(0, 0)
            end
        end

        self.mRedPaddle:update(dt)

        self.mRedbounds:forceInside(self.mRedPaddle.mBoundingCircle)
        self.mRedPaddle.mVec2Position = self.mRedPaddle.mBoundingCircle.center

    end
end

function PlayState:updatePuck(dt)
    self:paddlePuckCollision(self.mBluePaddle)
    self:paddlePuckCollision(self.mRedPaddle)

    if self.mPuck.mVelocity:length() >= MAX_PUCK_SPEED then 
        local normalizePuk = self.mPuck.mVelocity:normalize()
        normalizePuk:magnitude(MAX_PUCK_SPEED)
    end

    local puckCircle = self.mPuck.mBoundingCircle
    if puckCircle.center.x - puckCircle.radius < self.mBoardBounds.minPt.x then
        self.mPuck.mVelocity.x = self.mPuck.mVelocity.x * -1
    end
    if puckCircle.center.x + puckCircle.radius > self.mBoardBounds.maxPt.x then
        self.mPuck.mVelocity.x = self.mPuck.mVelocity.x * -1
    end
    if puckCircle.center.y - puckCircle.radius < self.mBoardBounds.minPt.y then
        self.mPuck.mVelocity.y = self.mPuck.mVelocity.y * -1
    end
    if puckCircle.center.y + puckCircle.radius > self.mBoardBounds.maxPt.y then
        self.mPuck.mVelocity.y = self.mPuck.mVelocity.y * -1
    end

    self.mPuck.mBoundingCircle = self.mBoardBounds:forceInside(self.mPuck.mBoundingCircle) -- -18, -18
    self.mPuck.mVec2Position = self.mPuck.mBoundingCircle.center

    self.mPuck:update(dt)

    if self.mBlueGoal:isPtInside(self.mPuck.mVec2Position) then
        self:increaseScore(false)
    end

    if self.mRedGoal:isPtInside(self.mPuck.mVec2Position) then
        self:increaseScore(true)
    end
end


function PlayState:paddlePuckCollision(paddle)
    local normal = Vector2(0,0)

    normal = paddle.mBoundingCircle:hits(self.mPuck.mBoundingCircle, normal)

    if (normal) then
        self.mPuck.mVec2Position = self.mPuck.mBoundingCircle.center

        local relVel = paddle.mVelocity:vectorSubtraction(self.mPuck.mVelocity)
        local impulseMag = relVel:dot(normal)

        if impulseMag >= 0 then

            local impulse = Vector2:multiply(normal, impulseMag)
            self.mPuck.mVelocity = self.mPuck.mVelocity:addTo(Vector2:multiply(impulse, 2))
            return true
        end
    end

    return false
end

function PlayState:increaseScore(bluePlayer)
    if bluePlayer then
        self.mblueScore = self.mblueScore + 1
    else
        self.mredScore = self.mredScore + 1
    end

    self.mPuck = nil
    self.mPuck = Sprite(path .. 'puck.png', Circle(18, self.mWndCenterPt), self.mWndCenterPt, Vector2(0, 0))

    if self.mblueScore == 1 or self.mredScore == 1 then
        gStateMachine:change('gameover', {
            blueScore = self.mblueScore, 
            redScore = self.mredScore
        })
    end

    --self:pause()
end


function PlayState:render()
   
    self.mGameBoard:render()
    self.mPuck:render()
    self.mBluePaddle:render()

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.mredScore), 8, 8)

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.mblueScore), 700, 8)
    self.mRedPaddle:render()
end