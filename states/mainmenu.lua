require 'state'

local MainMenu = State:subclass()

function MainMenu:init()
    MainMenu.super.init(self)
    self.bg = love.graphics.newImage('img/main.png')
end

function MainMenu:draw()
    MainMenu.super.draw(self)
    love.graphics.draw(self.bg, 0, 0)
end

function MainMenu:keyreleased(key)
    MainMenu.super.keyreleased(self, key)
    if key == 'q' then
        self.game:quit()
    end
end

return MainMenu:new()
