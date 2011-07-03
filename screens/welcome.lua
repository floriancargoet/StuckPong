require "screen"

local welcome = Screen:create()

function welcome:init()
    self.bg = love.graphics.newImage("img/welcome.png")
end

function welcome:draw()
    love.graphics.draw(self.bg, 0, 0)
end

function welcome:keyreleased(key)
    -- any key is fine
    game:gotoScreen('mainmenu') -- bad. do not use globals. use events.
end

return welcome