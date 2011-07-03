
-- Game class

Game = {}

function Game.loadScreen(screenName)
    return dofile('screens/'..screenName..'.lua')
end

function Game:create(game)
    -- here self = class
    game = game or {}
    setmetatable(game, self)
    self.__index = self
    game.screens = {}
    return game
end

function Game:quit()
    love.event.push('q')
end

function Game:gotoScreen(screenName)
    self.current = self:getScreen(screenName)
    self.current:reset()
end

function Game:getScreen(screenName)
    local screen = self.screens[screenName]
    if not screen then
        screen = Game.loadScreen(screenName)
        if not screen then
            error("Screen '"..screenName.."' does not exists", 3)
        end
        screen:init()
        self.screens[screenName] = screen
    end
    return screen
end

function Game:keypressed(key)
    self.current:keypressed(key)
end

function Game:keyreleased(key)
    self.current:keyreleased(key)
end

function Game:update(dt)
    self.current:update(dt)
end

function Game:draw()
    self.current:draw()
end