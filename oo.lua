-- simple class-like system
-- features:
--   - inheritance (sublasses, is_a, "super")
--   - static (just put stuff in the class table)
--   - base class Object
-- notes:
--   - do not use self.super.method(self)
--     it only works on one level!
--     use Class.super.method(self) instead

Object = {}
Object.class = Object

function Object:subclass(new)
  local parent = self
  local new = new or {}
  -- if something is not found in the class, search in the parent class
  setmetatable(new, {__index = parent})
  new.class = new
  new.super = parent
  return new
end

function Object:new(...)
  local instance = {}
  -- if something is not found in the instance, search in the class
  setmetatable(instance, {__index = self})
  instance:constructor(...)
  return instance
end

function Object:constructor()
end

function Object:apply(properties)
  for property, value in pairs(properties) do
    self[property] = value
  end
end

function Object:is_a(Class)
  local class = self.class
  while class do
    if class == Class then
      return true
    end
    class = class.super
  end
  return false
end
