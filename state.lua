require 'utils'

State = {}
State.__index = State

Observable:mixin(State)

function State:create(state)
    -- here self = class
    state = state or {}
    setmetatable(state, self)
    return state
end

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
