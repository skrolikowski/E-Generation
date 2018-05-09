--=======================================
-- filename:    entities/units/unit.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Unit object.
--=======================================

local Entity = require 'entities.entity'
local Enemy  = Entity:extend()

function Enemy:clearTarget()
    if self.tracker then
        self.tracker.target = nil
    end
end

-- ===================================
-- Register all event listeners.
-- -------------
-- @return void
-- ===================================
function Enemy:registerEvents()
    Event:listen(self, 'player.destroyed', self.clearTarget)
end

-- ===================================
-- Clear all event listeners.
-- -------------
-- @return void
-- ===================================
function Enemy:removeEvents()
    Event:remove('player.destroyed')
end

-- ===================================
-- Entity has collided with another.
-- -------------
-- @param entity - other entity
-- @param table  - collision normal
-- -------------
-- @return void
-- ===================================
function Enemy:collidedWith(entity, collision)
    if entity.name == 'player' then
        entity:takeDamage(self)
    elseif (entity.name == 'wall' and entity.switch) then
        self:rebound(collision.normal)
        entity.pressed = Vec2(collision.normal.x, collision.normal.y):heading()
    elseif entity.name == 'chaser'      or
           entity.name == 'soldier'     or
           entity.name == 'exit'        or
           entity.name == 'entrance'    or
           entity.name == 'wall'        or
           entity.name == 'crate'       or
           (entity.name == 'door' and entity.visible) or
           entity.group == 'decoration'
    then
        self:rebound(collision.normal)
    end
end

-- ===================================
-- Update the entity's position.
-- -------------
-- @param float = dt
-- -------------
-- @return void
-- ===================================
function Enemy:update(dt)
    self.fsm:update(dt)
    self.steer:update(dt)
    self.tracker:update(dt)

    controller.spawner:move(self, self:nextPosition(dt))
end

-- ===================================
-- Draw the entity.
-- -------------
-- @return void
-- ===================================
function Enemy:draw(iso)
    local cx, cy        = self:center()
    local x, y, w, h, d = self:container()
    local width, height = self.image:getDimensions()
    local sx, sy        = self.scale, self.scale

    if iso then
        -- Isometric
        cx, cy = UMath:cartesianToIsometric(cx, cy)
        w      = width * sx
        h      = height * sy
        cy     = cy - GRID['cell']['depth'] * GRID['cell']['size'] + self.depth

        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(self.image, cx-w/2, cy-h, 0, sx, sy)
    else
        -- Cartesian
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill', x, y, w, h)

        if self.fsm     then self.fsm:draw()     end
        if self.tracker then self.tracker:draw() end

        -- if self.path then
        --     self.path:draw()
        -- end

        -- -- debug
        -- if GAME['debug'] then
        --     -- axis-aligned bounding box
        --     love.graphics.setColor(255,0,0,255)
        --     love.graphics.setLineWidth(1)
        --     love.graphics.rectangle('line', self:AABB())

        --     -- velocity vector
        --     love.graphics.setColor(157,209,96,255)
        --     love.graphics.setLineWidth(2)
        --     love.graphics.line(cx, cy, cx + self.vel.x * 10, cy + self.vel.y * 10)
        -- end
    end
end

return Enemy