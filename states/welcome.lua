require 'state'

local WelcomeScreen = State:subclass()

function WelcomeScreen:init()
    WelcomeScreen.super.init(self)
    self.bg = love.graphics.newImage('img/welcome.png')
end

function WelcomeScreen:draw()
    WelcomeScreen.super.draw(self)
    love.graphics.draw(self.bg, 0, 0)
end

function WelcomeScreen:reset()
    self.ignoreInput = false
end

function WelcomeScreen:keyreleased(key)
    WelcomeScreen.super.keyreleased(self)
    if key == 'q' then
        self.game:quit()
    else
        self.ignoreInput = true
        self.game:transition('slide', 'mainmenu')
    end
end

return WelcomeScreen:new()
