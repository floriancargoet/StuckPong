
-- Game class

Game = {}
Game.__index = Game
-- constructor
function Game:create(game)
    -- here self = class
    game = game or {}
    setmetatable(game, self)

    game.loadedStates = {}
    game.stateStack   = {}
    game.currentState = nil -- quick access to the top state
    return game
end

function Game:start(stateName)
    self:pushState(stateName)
end

function Game:pushState(stateName)
    local state = self:getState(stateName)
    table.insert(self.stateStack, state)
    self.currentState = state
end

function Game:popState(stateName)
    table.remove(self.stateStack)
    self.currentState = self.stateStack[#self.stateStack]
end

-- State loader
function Game:loadState(stateName)
    return dofile('states/'..stateName..'.lua')
end

-- private - returns states, create and init if needed
function Game:getState(stateName)
    local state = self.loadedStates[stateName]
    if not state then
        state = self:loadState(stateName)
        if not state then
            error("State '"..stateName.."' does not exists", 3)
        end
        state.game = self
        state:init()
        state:on('exit', self.popState, self)
        self.loadedStates[stateName] = state
    else
        state:reset()
    end
    return state
end

-- quit shortcut
function Game:quit()
    love.event.push('q')
end

-- love callbacks
function Game:keypressed(key)
    self.currentState:keypressed(key)
end

function Game:keyreleased(key)
    self.currentState:keyreleased(key)
end

function Game:update(dt)
    self.currentState:update(dt)
end

function Game:draw()
    self.currentState:draw()
end
