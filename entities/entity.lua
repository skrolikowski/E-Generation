--=======================================
-- filename:    entities/entity.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Entity super class.
--=======================================

local Object = require 'tools.class'
local Entity = Object:extend()

function Entity:new()
    --
end

-- ===================================
-- Register all event listeners.
-- -------------
-- @return void
-- ===================================
function Entity:registerEvents()
    --
end

-- ===================================
-- Clear all event listeners.
-- -------------
-- @return void
-- ===================================
function Entity:removeEvents()
    --
end

-- ===================================
-- Get center coordinates of entity.
-- -------------
-- @return float (2x)
-- ===================================
function Entity:center()
    return self.pos:unpack()
end

-- ===================================
-- Get all points of entity.
-- -------------
-- @return table
-- ===================================
function Entity:getPoints()
    local x, y, w, h = self:container()

    return {
        Vec2(x, y),
        Vec2(x + w, y),
        Vec2(x + w, y + h),
        Vec2(x, y + h)
    }
end

-- ===================================
-- Get all line segments of entity.
-- -------------
-- @return table
-- ===================================
function Entity:getSegments()
    local points   = self:getPoints()
    local segments = {}

    for i = 1, #points do
        table.insert(segments, {
            p1 = points[i],
            p2 = points[i + 1] or points[1]
        })
    end

    return segments
end

-- ===================================
-- Determine if entity is within
--   bounds of the world.
-- -------------
-- @return boolean
-- ===================================
function Entity:inBounds()
    local x, y, w, h = self:container()

    return x > 0 and
           x + w < WORLD['width'] and
           y > 0 and
           y + h < WORLD['height']
end

-- ===================================
-- Get entity bounds (un-transformed).
-- -------------
-- @return floats
-- ===================================
function Entity:container()
    local cx, cy = self:center()
    local w      = self.width
    local h      = self.height
    local x      = cx - w / 2
    local y      = cy - h / 2
    local d      = self.depth

    return x, y, w, h, d
end

-- ===================================
-- Axis-aligned bounding box.
-- -------------
-- @return float (4x)
-- ===================================
function Entity:AABB()
    local cx, cy         = self:center()
    local x, y, w, h     = self:container()
    local angle          = self.angle or 0
    local x1, y1, x2, y2 = UMath:computeAABB(cx, cy, w, h, angle)

    w = x2 - x1
    h = y2 - y1

    return x1, y1, w, h
end

-- ===================================
-- Get entity's current cell.
-- -------------
-- @return Cell
-- ===================================
function Entity:cell()
    return controller.grid:getCellByLocation(self:center())
end

-- ===================================
-- Predict entity's next cell.
-- -------------
-- @return Cell
-- ===================================
function Entity:nextCell()
    local cell   = self:currentCell()
    local dx, dy = self.vel:copy():normalize():unpack()
    local row    = cell.row + dy
    local col    = cell.col + dx

    return controller.grid:getCell(row, col)
end

-- ===================================
-- Calculate entity's next position
--  based on acceleration forces.
-- -------------
-- @return Vec2
-- ===================================
function Entity:nextPosition(dt)
    -- outside forces
    -- self:applyDrag()

    -- apply accel forces
    self.vel:add(self.acc)
    self.acc:scale(0)

    -- adjust for `maxSpeed`
    self.vel:limit(self.maxSpeed)

    return self.pos:copy():add(self.vel)
end

-- ===================================
-- Apply drag force to acceleration.
-- -------------
-- @return void
-- ===================================
function Entity:applyDrag()
    local drag = self.vel:copy()
          drag:normalize()
          drag:scale(self.drag * self.vel:magnitudeSq())

    self:applyForce(drag)
end

-- ===================================
-- Apply force acceleration.
-- -------------
-- @param Vec2 - force
-- -------------
-- @return void
-- ===================================
function Entity:applyForce(force)
    force:scale(1 / self.mass)

    self.acc:add(force)
end

-- ===================================
-- Apply force acceleration with angle
--  and magnitude.
-- -------------
-- @param float - angle
-- @param float - magnitude
-- -------------
-- @return void
-- ===================================
function Entity:applyAngleMagnitude(angle, magnitude)
    local force = Vec2(0, 0)

    force:setAngle(angle)
    force:setMagnitude(magnitude)
    force:scale(1 / self.mass)

    self.acc:add(force)
end

-- ===================================
-- Adjust for entity overlapping.
-- -------------
-- @param entity - other entity
-- -------------
-- @return void
-- ===================================
-- function Entity:adjustForOverlapping(entity)
--     local direction = self.pos:copy():sub(entity.pos):normalize()
--     local distance  = self.pos:distance(entity.pos)
--     local depth     = (self.radius + entity.radius) - distance

--     self.pos = self.pos:add(direction:scale(depth))
-- end

-- ===================================
-- Rebound entity (rectangle collision response).
-- Reference: https://stackoverflow.com/a/45373126
-- -------------
-- @param entity - other entity
-- -------------
-- @return void
-- ===================================
-- function Entity:rebound(entity)
--     self:adjustForOverlapping(entity)

--     local cx, cy     = self:center()
--     local x, y, w, h = entity:container()

--     local nearestCorner = Vec2(
--         UMath:clamp(cx, x, x + w),
--         UMath:clamp(cy, y, y + h)
--     )

--     local direction = self.pos:copy():sub(nearestCorner):normalize()
--     local distance  = direction:magnitude()
--     local normal    = direction:normal()

--     local normalAngle   = normal:heading()
--     local incomingAngle = self.vel:heading()
--     local rotation      = 2 * (normalAngle - incomingAngle)

--     self.vel = self.vel:rotate(rotation)
-- end

-- ===================================
-- Rebound entity
-- -------------
-- @param normal vector
-- -------------
-- @return void
-- ===================================
function Entity:rebound(normal)
    if (normal.x < 0 and self.vel.x > 0) or
       (normal.x > 0 and self.vel.x < 0)
    then
        self.vel.x = -self.vel.x
    end

    if (normal.y < 0 and self.vel.y > 0) or
       (normal.y > 0 and self.vel.y < 0)
    then
        self.vel.y = -self.vel.y
    end
end

-- ===================================
-- Entity has collided with another.
-- -------------
-- @param entity - other entity
-- @param table  - collision data
-- -------------
-- @return void
-- ===================================
function Entity:collidedWith(entity, collision)
    --
end

-- ===================================
-- Entity has taken damage from attack.
-- -------------
-- @param entity = attacker
-- @param attack = damage (optional)
-- -------------
-- @return void
-- ===================================
function Entity:takeDamage(entity, attack)
    attack          = attack or entity.attack
    self.health.now = self.health.now - attack
    self.health.now = max(self.health.now, self.health.min)

    if self.health.now == self.health.min then
        self:destroy(entity)
    end
end

-- ===================================
-- Entity has been destroyed.
-- -------------
-- @param entity = destroyer
-- -------------
-- @return void
-- ===================================
function Entity:destroy(entity)
    controller.spawner:remove(self)

    if self.name == 'player' then
        Event:dispatch('player.destroyed')

        controller:reloadRoom()
    end
end

-- ===================================
-- One game tick has passed.
-- -------------
-- @param  float dt - time passed
-- -------------
-- @return void
-- ===================================
function Entity:tick(dt)
    --
end

-- ===================================
-- Update the entity.
-- -------------
-- @param float = dt
-- -------------
-- @return void
-- ===================================
function Entity:update(dt)
    --
end

-- ===================================
-- Draw the entity (isometric).
-- -------------
-- @return void
-- ===================================
function Entity:drawIsoShape(x, y, w, h, d, colors)
    -- top
    love.graphics.setColor(colors[1])
    love.graphics.polygon('fill',
        0, -d * h,
        w/2, h/2 - d * h,
        0, h - d * h,
        -w/2, h/2 - d * h
    )

    -- left
    love.graphics.setColor(colors[2])
    love.graphics.polygon('fill',
        -w/2, h/2 - d * h,
        0, h - d * h,
        0, h,
        -w/2, h/2
    )

    -- right
    love.graphics.setColor(colors[3])
    love.graphics.polygon('fill',
        w/2, h/2 - d * h,
        0, h - d * h,
        0, h,
        w/2, h/2
    )
end

-- ===================================
-- Draw the entity.
-- -------------
-- @return void
-- ===================================
function Entity:draw()
    --
end

return Entity