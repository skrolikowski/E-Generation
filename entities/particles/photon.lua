--=======================================
-- filename:    entities/particles/Photon.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Photon particle object.
--=======================================

local Particle = require 'entities.particles.particle'
local Photon  = Particle:extend()

function Photon:new(x, y, angle)
    self.name   = 'photon'
    self.group  = 'heavy_weapon'
    self.tags   = { 'photon', 'particle' }

    self.pos    = Vec2(x, y)
    self.vel    = Vec2(0, 0)
    self.acc    = Vec2(0, 0)

    self.image  = love.graphics.newImage('assets/particles/photon/model.png')
    self.imageS = 0.6
    self.imageW = self.image:getWidth() * self.imageS
    self.imageH = self.image:getHeight() * self.imageS

    self.scale  = 0.45
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.angle  = angle
    self.mass   = 1
    self.speed  = 3
    self.attack = 3
    self.color  = {24,255,13,255}

    -- force limits
    self.maxSpeed = self.speed
    self.maxForce = 0.25

    -- collision reaction
    self.react  = function(item, other)
        if other.reaction then
            return other.reaction
        end

        return 'touch'
    end
end

-- ===================================
-- Entity has collided with another.
-- -------------
-- @param entity - other entity
-- @param table  - collision normal
-- -------------
-- @return void
-- ===================================
function Photon:collidedWith(entity, collision)
    if entity.name == 'photon'   or
       entity.name == 'wall'     or
       entity.name == 'crate'    or
       (entity.group == 'decoration' and not entity.destructible) or
       (entity.name == 'door' and entity.visible)
    then
        self:destroy(entity)
    elseif entity.name == 'player'  or
           (entity.group == 'decoration' and entity.destructible) or
           (entity.group == 'enemy' and entity.destructible) or
           (entity.name == 'turret' and entity.active)
    then
        self:destroy(entity)
        entity:takeDamage(self)
    end
end

return Photon