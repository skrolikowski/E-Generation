--=======================================
-- filename:    entities/environments/elevator.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Elevator entity.
--=======================================

local Environment = require 'entities.environments.environment'
local Elevator    = Environment:extend()

function Elevator:new(x, y, heading)
    self.name    = 'elevator'
    self.tags    = { 'elevator', 'environment' }
    self.visible = true

    self.pos    = Vec2(x, y)
    self.scale  = 1
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.angle  = ANGLES['headings'][heading]
    self.mass   = 1
    self.image  = love.graphics.newImage('assets/environments/elevator/model_' .. heading .. '.png')
    self.colors = {
        {57,62,70,255},
        {17,45,78,255},
        {0,0,0,255}
    }

    self:cell().weight = nil
end

-- ===================================
-- Draw the entity.
-- -------------
-- @return void
-- ===================================
function Elevator:draw(iso)
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
        love.graphics.setColor(self.colors[1])
        love.graphics.rectangle('fill', x, y, w, h)
    end
end

return Elevator