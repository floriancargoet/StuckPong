require 'state'

local main = State:create()

function main:init()
    self.bg = love.graphics.newImage('img/main.png')
end

function main:draw()
    love.graphics.draw(self.bg, 0, 0)
end

function main:keyreleased(key)
    if key == 'q' then
        self.game:quit()
    end
end

return main
