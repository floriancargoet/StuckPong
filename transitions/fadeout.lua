require 'transition'

local FadeOut = Transition:subclass()

FadeOut.duration = 0.500 -- seconds
FadeOut.color    = {0, 0, 0}

function FadeOut:constructor(game)
    self.width  = game.width
    self.height = game.height
    self.step   = 0
end

function FadeOut:update(dt)
    self.step = self.step + (dt/self.duration)*255
    if self.step > 255 then
        self.step = 255
        self:trigger('end')
    end
end

function FadeOut:draw()
    -- save current color
    local oldColor = { love.graphics.getColor() }
    -- change color
    local r, g, b = unpack(self.color)
    local a = math.floor(self.step)
    love.graphics.setColor(r, g, b, a)
    love.graphics.rectangle('fill', 0, 0, self.width, self.height)
    -- restore color
    love.graphics.setColor(unpack(oldColor))
end

return FadeOut
