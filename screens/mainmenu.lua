require "screen"

local main = Screen:create()

function main:init()
    self.bg = love.graphics.newImage("img/main.png")
end

function main:draw()
    love.graphics.draw(self.bg, 0, 0)
end

function main:keyreleased(key)
    if key == 'q' then
        self:exit()
    end
end

return main