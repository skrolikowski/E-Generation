--=======================================
-- filename:    entities/environments/crate.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Pushable crate entity.
--=======================================

local Environment = require 'entities.environments.environment'
local Crate       = Environment:extend()

function Crate:new(x, y)
    self.name   = 'crate'
    self.tags   = { 'crate', 'environment' }

    self.pos    = Vec2(x, y)
    self.vel    = Vec2(0, 0)
    self.acc    = Vec2(0, 0)
    self.scale  = 0.6
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.mass  = 1
    self.image = love.graphics.newImage('assets/environments/crate/model.png')
    self.color = {161,108,68,255}

    -- force limits
    self.maxSpeed = 150
    self.maxForce = 0.25

    -- collision reaction
    self.react  = function(item, other)
        if other.name == 'fswitch' or
           (other.name == 'door' and other.visible == false)
        then
            return 'cross'
        end

        return 'slide'
    end
end

-- ===================================
-- Crate is being pushed.
-- -------------
-- @param float angle
-- @param int   speed
-- -------------
-- @return void
-- ===================================
function Crate:push(angle, speed)
    self:applyAngleMagnitude(angle, speed)
end

-- ===================================
-- Entity has collided with another.
-- -------------
-- @param entity - other entity
-- @param table  - collision normal
-- -------------
-- @return void
-- ===================================
function Crate:collidedWith(entity, collision)
    if entity.name == 'fswitch' then
        entity.occupantMass = entity.occupantMass + self.mass
    elseif entity.name == 'wswitch' then
        entity.active = true
    end
end

-- ===================================
-- Update unit entity's position.
-- -------------
-- @param integer dt - delta time
-- -------------
-- @return void
-- ===================================
function Crate:update(dt)
    self.vel:scale(0)

    controller.spawner:move(self, self:nextPosition(dt))
end

-- ===================================
-- Draw the entity.
-- -------------
-- @return void
-- ===================================
function Crate:draw(iso)
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
    end
end

return Crate