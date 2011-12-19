require 'game'

local game     = Game:new()
local showFPS  = true
local showMore = true
local maxDt    = 16 -- ~= 1000/60

-- delegate everything
function love.load()
    game:start('welcome') -- load the first screen
end

function love.keypressed(key)
    game:keypressed(key)
end

function love.keyreleased(key)
    if key == 'escape' then
        game:quit()
    elseif key == 'f3' then
        showFPS = not showFPS
    elseif key == 'f4' then
        showMore = not showMore
    else
        game:keyreleased(key)
    end
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
    if showFPS then
        love.graphics.print('FPS: '..love.timer.getFPS(), 0, 0)
    end
    if showMore then
        local x, y = love.mouse.getPosition()
        love.graphics.print('Mouse: '..x..', '..y, 0, 20)
    end

    --max 60 fps
    local dt = love.timer.getDelta()/1000
    if dt < maxDt then
        love.timer.sleep(maxDt - dt)
    end
end
