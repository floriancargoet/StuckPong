require 'transition'

local Slide = Transition:subclass()

Slide.duration = 0.5 -- seconds

function Slide:constructor(game)
    self.width     = game.width
    self.height    = game.height
    self.rectWidth = 0
end

function Slide:update(dt)
    self.rectWidth = self.rectWidth + (dt/self.duration)*self.width
    if self.rectWidth > self.width then
        self.rectWidth = self.width
        self:trigger('end')
    end
end

function Slide:draw()
    -- save current color
    local oldColor   = { love.graphics.getColor() }
    
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', 0, 0, self.rectWidth, self.height)
    
    -- restore color
    love.graphics.setColor(unpack(oldColor))
end

return Slide
