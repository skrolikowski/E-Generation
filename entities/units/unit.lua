--=======================================
-- filename:    entities/units/unit.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Unit super class.
--=======================================

local Entity = require 'entities.entity'
local Unit   = Entity:extend()

function Unit:move(axis, value)
    if axis == 1 then dx = value end
    if axis == 2 then dy = value end

    local angle = Vec2(dx, dy):heading()
    local nearest, idx

    self:applyAngleMagnitude(angle, self.speed)
    self.angle = self.vel:heading()

    if self.angle < 0 then
        self.angle = self.angle + math.pi * 2
    end

    nearest, idx = UMath:closest(self.angle, ANGLES['sixteenths'])
    self.heading = idx

    -- if self.moving == nil then
    --     AUDIO['unit'][1]:play()
    --     AUDIO['unit'][1]:setLooping(true)
    --     self.moving  = true
    -- end
end

function Unit:rest(axis)
    if axis == 1 then dx = 0 end
    if axis == 2 then dy = 0 end

    self.vel:scale(0)
    -- self.moving = nil

    -- AUDIO['unit'][1]:stop()
    -- AUDIO['unit'][1]:rewind()
end

-- ===================================
-- Update unit entity's position.
-- -------------
-- @param integer dt - delta time
-- -------------
-- @return void
-- ===================================
function Unit:update(dt)
    local nextPos = self:nextPosition(dt)

    if self.posLock == true then
        nextPos = self.pos
    end

    controller.spawner:move(self, nextPos)
end

-- ===================================
-- Entity has collided with another.
-- -------------
-- @param entity - other entity
-- @param table  - collision normal
-- -------------
-- @return void
-- ===================================
function Unit:collidedWith(entity, collision)
    if entity.name == 'exit' then
        self:goToRoom(controller.room, entity.roomIndex)
    elseif entity.name == 'crate' then
            entity:push(self.angle, self.speed / 2)
    elseif (entity.name == 'wall' and entity.switch) then
        entity.pressed = Vec2(collision.normal.x, collision.normal.y):heading()
    elseif entity.name == 'fswitch' then
        entity.occupantMass = entity.occupantMass + self.mass
    elseif (entity.name == 'zapper' and entity.active) then
        self:takeDamage(entity)
    end
end

return Unit