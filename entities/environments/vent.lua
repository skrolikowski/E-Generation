--=======================================
-- filename:    entities/environments/vent.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Vent entity.
--=======================================

local Environment = require 'entities.environments.environment'
local Vent        = Environment:extend()

function Vent:new(x, y, depth, heading)
    self.name    = 'vent'
    self.tags    = { 'vent', 'environment' }
    self.pos     = Vec2(x, y)
    self.width   = GRID['cell']['size']
    self.height  = GRID['cell']['size']
    self.depth   = GRID['cell']['size'] * depth

    -- attributes
    self.image    = love.graphics.newImage('assets/environments/vent/model_' .. heading .. '.png')
    self.imageS   = 1
    self.imageW   = self.image:getWidth() * self.imageS
    self.imageH   = self.image:getHeight() * self.imageS
    self.reaction = 'cross'
end

-- ===================================
-- Draw the entity.
-- -------------
-- @return void
-- ===================================
function Vent:draw(iso)
    local cx, cy        = self:center()
    local x, y, w, h, d = self:container()
    local width, height = self.image:getDimensions()
    local sx, sy        = 0.85, 0.85

    if iso then
        -- Isometric
        cx, cy = UMath:cartesianToIsometric(cx, cy)
        cx     = cx + GRID['cell']['size'] / 3
        cy     = cy - GRID['cell']['depth'] * GRID['cell']['size'] - self.depth

        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(self.image, cx - self.imageW / 2, cy - self.imageH, 0, self.imageS, self.imageS)
    end
end

return Vent