-- a Mixin class
-- Usage:
--  * create a new mixin with methods
--     Closable = Mixin.create()
--     function Closable:close() print('close') end
--  * apply the mixin to a "class" or an instance
--     Closable.mixin(Window)
--     w = Window:create()
--     w:close() --> prints 'close'
--
-- mixin() fails if method names conflict

Mixin = {}

function Mixin:create(mixin) -- type: table
    -- here self = class
    mixin = mixin or {}
    setmetatable(mixin, self)
    self.__index = self
    return mixin
end

function Mixin:mixin(class) -- type: table
    for name, method in pairs(self) do
        if class[name] then
            error("Method "..name.." already exists!", 2)
        else
            class[name] = method
        end
    end
    return class
end



-- an Observable mixin
-- see usage in commented code below

Observable = Mixin:create()

function Observable:on(event, handler, context) -- type: any, function, table
    if not event then
        error('event cannot be nil', 2)
    end
    if not handler then
        error('handler cannot be nil', 2)
    end
    
    self.events = self.events or {}
    self.events[event] = self.events[event] or {}
    table.insert(self.events[event], {handler = handler, context = context})
end

function Observable:trigger(event, ...) -- type: any, ...
    local handlers = self.events and self.events[event]
    if handlers then
        for _, hc in ipairs(handlers) do
            if hc.context then -- handler requires a 'self' value
                hc.handler(hc.context, unpack(arg))
            else
                hc.handler(unpack(arg))
            end
        end
    end
end
