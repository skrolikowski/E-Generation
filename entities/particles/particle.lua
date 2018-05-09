--=======================================
-- filename:    entities/particles/particle.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Particle object.
--=======================================

local Entity   = require 'entities.entity'
local Particle = Entity:extend()

-- ===================================
-- Launch self.
-- -------------
-- @return void
-- ===================================
function Particle:launch()
    self:applyAngleMagnitude(self.angle, self.speed)
end

-- ===================================
-- Update the particle.
-- -------------
-- @param flot - time passed
-- -------------
-- @return void
-- ===================================
function Particle:update(dt)
    controller.spawner:move(self, self:nextPosition(dt))

    if not self:inBounds() then
        self:destroy(nil)
    end
end

-- ===================================
-- Draw the particle.
-- -------------
-- @return void
-- ===================================
function Particle:draw(iso)
    local cx, cy        = self:center()
    local x, y, w, h, d = self:container()

    if iso then
        -- Isometric
        cx, cy = UMath:cartesianToIsometric(cx, cy)
        cy     = cy - GRID['cell']['depth'] * GRID['cell']['size'] + self.depth

        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(self.image, cx - self.imageW / 2, cy - self.imageH, 0, self.imageS, self.imageS)
    else
        -- Cartesian
        love.graphics.setColor(self.color)
        love.graphics.circle('fill', cx, cy, self.width / 2)
    end
end

return Particle