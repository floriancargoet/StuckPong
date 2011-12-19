require 'oo'
require 'utils'

State = Object:subclass()

Observable:mixin(State)

function State:exit()
    self:trigger('exit')
end

-- called before push if first time
function State:init()
end

-- called before push if not first time
function State:reset()
end

function State:keypressed(key)
end

function State:keyreleased(key)
end

function State:update(dt)
end

function State:draw()
end
