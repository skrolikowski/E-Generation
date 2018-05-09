--=======================================
-- filename:    entities/units/civilian.lua
-- author:      Shane Krolikowski
-- created:     May, 2018
-- description: Civilian unit entity.
--=======================================

local Unit     = require 'entities.units.unit'
local Civilian = Unit:extend()

function Civilian:new(x, y, heading)
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
    self.color   = {70,0,3,255}

    -- brain/steering
    self.fsm   = FSM(self, 'idle')
    self.steer = SManager(self)

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
-- (FSM) Unit is idle.
-- -------------
-- @return void
-- ===================================
function Civilian:idle()
    --
end

-- ===================================
-- (FSM) Unit is following.
-- -------------
-- @return void
-- ===================================
function Civilian:follow()
    -- todo
    -- self.steer:followLeader(player, 100)
end

-- ===================================
-- Draw player entity.
-- -------------
-- @return void
-- ===================================
function Civilian:draw(iso)
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

return Civilian