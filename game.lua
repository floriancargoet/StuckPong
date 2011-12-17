
-- Game class

Game = {}
Game.__index = Game
-- constructor
function Game:create(game)
    -- here self = class
    game = game or {}
    setmetatable(game, self)
    game.screens = {}

    game.currentScreen = nil
    game.currentScreenIndex = 0

    return game
end

function Game:declareScreens(...)
    self.screenOrder = arg
end

function Game:start()
    self:gotoNextScreen()
end

function Game:gotoNextScreen()
    self.currentScreenIndex = self.currentScreenIndex + 1
    local screenName = self.screenOrder[self.currentScreenIndex]
    if screenName then
        self:gotoScreen(screenName)
    else
        self:quit()
    end

end

-- Screen loader
function Game.loadScreen(screenName)
    return dofile('screens/'..screenName..'.lua')
end

-- quit shortcut
function Game:quit()
    love.event.push('q')
end

-- change current screen
function Game:gotoScreen(screenName)
    self.currentScreen = self:getScreen(screenName)
    self.currentScreen:reset()

    self.currentScreen:on('exit', self.gotoNextScreen, self)
end

-- private - returns screens, create and init if needed
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

-- love callbacks
function Game:keypressed(key)
    self.currentScreen:keypressed(key)
end

function Game:keyreleased(key)
    self.currentScreen:keyreleased(key)
end

function Game:update(dt)
    self.currentScreen:update(dt)
end

function Game:draw()
    self.currentScreen:draw()
end
