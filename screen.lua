require 'utils'

Screen = {}
Screen.__index = Screen

Observable:mixin(Screen)

function Screen:create(screen)
    -- here self = class
    screen = screen or {}
    setmetatable(screen, self)
    return screen
end

function Screen:exit()
    self:trigger('exit')
end

function Screen:init()
end

function Screen:reset()
end

function Screen:keypressed(key)
end

function Screen:keyreleased(key)
end

function Screen:update(dt)
end

function Screen:draw()
end
