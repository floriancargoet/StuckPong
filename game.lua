require 'oo'

-- Game class
Game = Object:subclass()

function Game:constructor(width, height)
    self.width        = width
    self.height       = height
    self.loadedStates = {}
    self.stateStack   = {}
    self.currentState = nil -- quick access to the top state
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


function Game:transition(type, nextState)
    local transition = self.transitions[type]:new(self)
    if transition then
        transition:on('end', function()
            self.currentTransition = nil
            self:pushState(nextState)
        end, self)
        self.currentTransition = transition
    else
        self:pushState(nextState)
    end
end

-- quit shortcut
function Game:quit()
    love.event.push('q')
end

-- love callbacks
function Game:keypressed(key)
    if not self.currentState.ignoreInput then
        self.currentState:keypressed(key)
    end
end

function Game:keyreleased(key)
    if not self.currentState.ignoreInput then
        self.currentState:keyreleased(key)
    end
end

function Game:update(dt)
    self.currentState:update(dt)
    if self.currentTransition then
        self.currentTransition:update(dt)
    end
end

function Game:draw()
    self.currentState:draw()
    if self.currentTransition then
        self.currentTransition:draw()
    end
end

Game.transitions = {
    fadeout = require('transitions/fadeout'),
    slide   = require('transitions/slide')
}
