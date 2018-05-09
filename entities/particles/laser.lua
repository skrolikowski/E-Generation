--=======================================
-- filename:    entities/particles/laser.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Laser particle object.
--=======================================

local Particle = require 'entities.particles.particle'
local Laser    = Particle:extend()

function Laser:new(x, y, angle)
    self.name   = 'laser'
    self.group  = 'light_weapon'
    self.tags   = { 'laser', 'particle' }

    self.pos    = Vec2(x, y)
    self.vel    = Vec2(0, 0)
    self.acc    = Vec2(0, 0)

    self.image  = love.graphics.newImage('assets/particles/laser/model.png')
    self.imageS = 0.5
    self.imageW = self.image:getWidth() * self.imageS
    self.imageH = self.image:getHeight() * self.imageS

    self.scale  = 0.65
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.angle  = angle
    self.mass   = 1
    self.speed  = 8
    self.attack = 1
    self.color  = {72,200,255,255}
    self.health = { now = 1, min = 0, max = 1 }

    -- force limits
    self.maxSpeed = self.speed
    self.maxForce = 0.25

    -- collision reaction
    self.react  = function(item, other)
        if other.reaction then
            return other.reaction
        end

        return 'bounce'
    end
end

function Laser:collidedWith(entity, collision)
    if entity.name == 'player' or
       entity.name == 'photon' or
       (entity.group == 'decoration' and not entity.destructible)
    then
        self:destroy(entity)
    elseif entity.name == 'laser' then
        self:destroy(entity)
        entity:destroy(self)
    elseif (entity.group == 'decoration' and entity.destructible) or
           (entity.group == 'enemy' and entity.destructible)
    then
        self:destroy(entity)
        entity:takeDamage(self)
    elseif (entity.name == 'wall' and entity.switch) then
        self:rebound(collision.normal)
        self:takeDamage(entity, 0.25)
        entity.pressed = Vec2(collision.normal.x, collision.normal.y):heading()
    elseif entity.name == 'wall'  or
           entity.name == 'crate' or
           (entity.name == 'turret' and entity.active) or
           (entity.name == 'door' and entity.visible)
    then
        self:rebound(collision.normal)
        self:takeDamage(entity, 0.25)
    end
end

return Laser