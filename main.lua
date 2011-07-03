require "game"

game = Game:create()

-- delegate everything
function love.load()
    game:gotoScreen('welcome')
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