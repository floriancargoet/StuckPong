require 'game'

local game    = Game:create()
local showFPS = true
local maxDt   = 16 -- ~= 1000/60

game:declareScreens('welcome', 'mainmenu') -- bad system. I need a nested screens system

-- delegate everything
function love.load()
    game:start() -- load the first screen
end

function love.keypressed(key)
    game:keypressed(key)
end

function love.keyreleased(key)
    if key == 'escape' then
        game:quit()
    elseif key == 'f3' then
        showFPS = not showFPS
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

    --max 60 fps
    local dt = love.timer.getDelta()/1000
    if dt < maxDt then
        love.timer.sleep(maxDt - dt)
    end
end
