--require 'Vec2'
--require 'Sprite'
--require 'Rectangle'
--require 'Circle'
--[[
AirHockeyGame  = Class{}

--local MAX_PUCK_SPEED
--local RED_SPEED

function AirHockeyGame:init(center)
    --self.mblueScore = 0
    --self.mredScore = 0
    --self.mPaused = true
    --self.mRedRecoverTime = 0.0

    --local bc = Circle()
    self.bc = "6"--center--Circle()
    

    local p0 = center
    local v0 = Vec2(0.0, 0.0)

    -- sprites
    self.mGameBoard = Sprite('hockeyboard.png', bc, p0, v0)

    bc.c = p0
    bc.r = 18.0
    self.mPuck = Sprite('puck.png', bc, p0, v0)

    p0.x = 700
	p0.y = 200
    bc.c = p0
	bc.r = 25.0
    self.mBluePaddle = Sprite('redPaddle.png', bc, p0, v0)

    p0.x = 100
	p0.y = 100
	bc.c = p0
	bc.r = 25.0
    self.mRedPaddle = Sprite('bluePaddle.png', bc)

    -- point
    self.mLastMousePos = 0 
    self.mCurrMousePos = 0

    -- bounds
    self.mBlueBounds = Rectangle(7, 40, 432, 436)
    self.mRedbounds = Rectangle(432, 40, 854, 463)
    self.mBoardBounds = Rectangle(7, 40, 854, 463)
    self.mBlueGoal = Rectangle(0, 146, 30, 354)
    self.mRedGoal = Rectangle(833, 146, 863, 354)
    ]]
end
--[[
function AirHockeyGame:pause()
    self.mPaused = true  
    love.mouse.setVisible(true)
end

function AirHockeyGame:unpause()
    local bluePaddlePos = self.mBluePaddle.mPosition
    love.mouse.setPosition(bluePaddlePos.x, bluePaddlePos.y)
    
    self.mPaused = false
    love.mouse.setVisible(false)
end

function AirHockeyGame:update(dt)
    --if not self.mPaused then
    --    updateBluePaddle(dt)
     --   updateRedPaddle(dt)
    --    updatePuck(dt)

    --    if self.mRedRecoverTime > 0.0 then 
    --        self.mRedRecoverTime = self.mRedRecoverTime - dt
    --    end
   -- end
end

function AirHockeyGame:render()
    love.graphics.printf(self.bc.radius, 0, 64, VIRTUAL_WIDTH, 'center')
    --if not self.mGameBoard == nil then
        --self.mGameBoard.draw()
    --end
    --self.mBluePaddle.draw()
    --self.mRedPaddle.draw()
    --self.mPuck.draw()

    -- score
end


function AirHockeyGame:updateBluePaddle(dt)
    local x, y = love.mouse.getPosition()
    local dx = x - self.mLastMousePos.x
    local dy = y - self.mLastMousePos.y

    local dp = Vec2(dx, dy)
    self.mBluePaddle.mVelocity = dp.Divide(dt)
    self.mBluePaddle.update()

    self.mBlueBounds.forceInside(self.mBluePaddle.mBoundingCircle)
    self.mPosition = self.mBluePaddle.mBoundingCircle.center

    self.mLastMousePos = slef.bluePaddle.mPosition

    love.mouse.setPosition(mLastMousePos.x, mLastMousePos.y)
end
]]