--=======================================
-- filename:    entities/enemies/oracle.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Oracle enemy entity.
--=======================================

local Enemy  = require 'entities.enemies.enemy'
local Oracle = Enemy:extend()

function Oracle:new(x, y, heading)
    self.name   = 'oracle'
    self.group  = 'enemy'
    self.tags   = { 'oracle', 'enemy', 'mobile' }

    self.pos = Vec2(x, y)
    self.vel = Vec2(0, 0)
    self.acc = Vec2(0, 0)

    self.scale  = 0.75
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = 1

    -- attributes
    self.image        = love.graphics.newImage('assets/enemies/oracle/model.png')
    self.mass         = 1
    self.angle        = ANGLES['sixteenths'][tonumber(heading)]
    self.speed        = 4
    self.attack       = 5
    self.destructible = false
    self.color        = {102,0,51,255}

    -- force limits
    self.maxSpeed = 2
    self.maxForce = 0.25

    self:applyAngleMagnitude(self.angle, self.speed)
end

-- ===================================
-- Update the entity's position.
-- -------------
-- @param float = dt
-- -------------
-- @return void
-- ===================================
function Oracle:update(dt)
    controller.spawner:move(self, self:nextPosition(dt))
end


return Oracle