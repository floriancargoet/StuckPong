require "game"

local game    = Game:create()
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
    else
        game:keyreleased(key)
    end
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end