--=======================================
-- filename:    entities/environments/door.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Door entity.
--=======================================

local Environment = require 'entities.environments.environment'
local Door        = Environment:extend()

function Door:new(x, y, code, color, open)
    self.name  = 'door'
    self.group = 'barrier'
    self.tags  = { 'door', 'environment' }

    self.pos    = Vec2(x, y)
    self.width  = GRID['cell']['size']
    self.height = GRID['cell']['size']

    -- attributes
    self.code         = code
    self.closeDelay   = 0
    self.actionTicks  = { min = 0, max = 2 }
    self.actionSpeed  = 5
    self.action       = nil

    if open == 'T' then
        self.closed      = false
        self.visible     = false
        self.reaction    = 'cross'
        self.actionTimer = self.actionTicks.min
        self.depth       = 0
    else
        self.closed      = true
        self.visible     = true
        self.reaction    = nil
        self.actionTimer = self.actionTicks.max
        self.depth       = 1
    end

    -- color attribute
    self.colors = UI['color']['door'][color]
    self:cell().colors[1] = self.colors[1]
    self:cell().colors[4] = self.colors[1]

    self.excludeFilter = function(entity)
        if entity.name == self.name then
            return false
        end

        return true
    end
end

function Door:set()

end

-- ===================================
-- Register all event listeners.
-- -------------
-- @return void
-- ===================================
function Door:registerEvents()
    Event:listen(self, 'switch.pushed',    self.open)
    Event:listen(self, 'switch.released',  self.close)
    Event:listen(self, 'switch.triggered', self.trigger)
end

-- ===================================
-- Clear all event listeners.
-- -------------
-- @return void
-- ===================================
function Door:removeEvents()
    Event:remove('switch.pushed')
    Event:remove('switch.released')
    Event:remove('switch.triggered')
end

-- ===================================
-- Check if this door is occupied by
--  another entity.
-- -------------
-- @param  string code
-- -------------
-- @return boolean
-- ===================================
function Door:occupied(code)
    local entities = controller.spawner:getEntities(self.name)
    local count = 0
    local visitors, len

    for _, entity in pairs(entities) do
        if self.code == code then
            visitors, len = controller.spawner:queryCell(entity:cell(), entity.excludeFilter)
            count         = count + len
        end
    end

    return count > 0
end

-- ===================================
-- Door has been triggered.
-- -------------
-- @param  string code
-- -------------
-- @return void
-- ===================================
function Door:trigger(code)
    if self.closed then
        self:open(code)
    else
        self:close(code)
    end
end

-- ===================================
-- Door has been triggered open.
-- -------------
-- @param  string code
-- -------------
-- @return void
-- ===================================
function Door:open(code)
    if self.code == code then
        if self.closed then
            self.visible  = true
            self.reaction = nil
            self.action   = self.opening
        end
    end
end

-- ===================================
-- Door has been triggered closed.
-- -------------
-- @param  string code
-- -------------
-- @return void
-- ===================================
function Door:close(code)
    if self.code == code then
        if not self.closed and not self:occupied(code) then
            self.visible  = true
            self.reaction = 'cross'
            self.action   = self.closing
        end
    end
end

function Door:opening(tick)
    self.actionTimer = self.actionTimer - tick
    self.depth       = self.actionTimer / self.actionTicks.max

    if self.actionTimer <= self.actionTicks.min then
        self.visible  = false
        self.reaction = 'cross'
        self.action   = nil
        self.closed   = false
    end
end

function Door:closing(tick)
    self.actionTimer = self.actionTimer + tick
    self.depth       = self.actionTimer / self.actionTicks.max

    if self.actionTimer >= self.actionTicks.max then
        self.visible  = true
        self.reaction = nil
        self.action   = nil
        self.closed   = true
    end
end

-- ===================================
-- Update door entity.
-- -------------
-- @param  float dt - time passed
-- -------------
-- @return void
-- ===================================
function Door:update(dt)
    if self.action ~= nil then
        self.action(self, self.actionSpeed * dt)
    end
end

return Door