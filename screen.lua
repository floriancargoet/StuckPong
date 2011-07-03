Screen = {}

function Screen:create(screen)
    -- here self = class
    screen = screen or {}
    setmetatable(screen, self)
    self.__index = self
    return screen
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