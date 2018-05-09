--=======================================
-- filename:    entities/units/player.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Player entity.
--=======================================

local Unit   = require 'entities.units.unit'
local Player = Unit:extend()

function Player:new(x, y, heading)
    self.name  = 'player'
    self.group = 'unit'
    self.tags  = { 'player', 'unit' }

    self.pos  = Vec2(x, y)
    self.vel  = Vec2(0, 0)
    self.acc  = Vec2(0, 0)
    self.posLock = false

    self.scale  = 0.75
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size']/2 * self.scale

    -- attributes
    self.heading = heading or 1
    self.angle   = ANGLES['sixteenths'][self.heading]
    self.mass    = 1
    self.speed   = 3
    self.health  = { now = 1, min = 0, max = 1 }
    self.color   = {151,0,37,255}

    -- image
    self.image  = IMAGE['unit']['player'][1]
    self.imageS = 0.75
    self.imageW = 42 * self.imageS
    self.imageH = 85 * self.imageS

    -- force limits
    self.maxSpeed = self.speed
    self.maxForce = 0.25

    -- collision reaction
    self.react  = function(item, other)
        if other.reaction then
            return other.reaction
        end

        return 'slide'
    end
end

-- ===================================
-- Register all event listeners.
-- -------------
-- @return void
-- ===================================
function Player:registerEvents()
    Event:listen(self, 'player.fire',        self.fire)
    Event:listen(self, 'player.move',        self.move)
    Event:listen(self, 'player.adjustAngle', self.adjustAngle)
    Event:listen(self, 'player.rest',        self.rest)
    Event:listen(self, 'player.enableRun',   function() self.maxSpeed = self.speed * 1.5 end)
    Event:listen(self, 'player.disableRun',  function() self.maxSpeed = self.speed * 1   end)
    Event:listen(self, 'player.enableLock',  function() self.posLock  = true             end)
    Event:listen(self, 'player.disableLock', function() self.posLock  = false            end)
end

-- ===================================
-- Clear all event listeners.
-- -------------
-- @return void
-- ===================================
function Player:removeEvents()
    Event:remove('player.fire')
    Event:remove('player.move')
    Event:remove('player.adjustAngle')
    Event:remove('player.rest')
    Event:remove('player.enableRun')
    Event:remove('player.disableRun')
    Event:remove('player.enableLock')
    Event:remove('player.disableLock')
end

-- ===================================
-- Player fire's laser.
-- -------------
-- @return void
-- ===================================
function Player:fire()
    local cx, cy = self:center()
    local nx     = cx + math.cos(self.angle) * GRID['cell']['size']
    local ny     = cy + math.sin(self.angle) * GRID['cell']['size']
    local laser

    laser = Laser(nx, ny, self.angle)
    laser:launch()

    -- AUDIO['particle'][1]:play()
    -- AUDIO['particle'][1]:rewind()

    controller.spawner:add(laser)
end

-- ===================================
-- Move to next room.
-- -------------
-- @param string - roomIndex
-- -------------
-- @return void
-- ===================================
function Player:goToRoom(currentIndex, roomIndex)
    if self.changing == nil then
        self.changing = true

        controller:reset()
        controller:setSpawn(currentIndex)
        controller:loadRoom(controller.floor, roomIndex)
    end
end

-- ===================================
-- Draw player entity.
-- -------------
-- @return void
-- ===================================
function Player:draw(iso)
    local cx, cy        = self:center()
    local x, y, w, h, d = self:container()

    if iso then
        -- Isometric
        cx, cy = UMath:cartesianToIsometric(cx, cy)
        cy     = cy - GRID['cell']['depth'] * GRID['cell']['size'] + self.depth

        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(self.image, QUAD['unit']['player'][self.heading], cx - self.imageW / 2, cy - self.imageH, 0, self.imageS, self.imageS)
    else
        -- Cartesian
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill', x, y, w, h)
    end
end

return Player