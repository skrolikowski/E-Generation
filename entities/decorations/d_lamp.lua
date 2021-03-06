--=======================================
-- filename:    entities/decorations/d_lamp.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Desk lamp decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local DLamp      = Decoration:extend()

function DLamp:new(x, y, heading)
    self.name  = 'd_lamp'
    self.group = 'decoration'
    self.tags  = { 'd_lamp', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/desk lamp/model_' .. heading .. '.png')
    self.scale  = 0.5
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale

    -- attributes
    self.destructible = true
    self.health       = { now = 1, min = 0, max = 1 }
    self.color        = {90,131,53,255}
end

function DLamp:draw(iso)
    local cx, cy        = self:center()
    local x, y, w, h, d = self:container()
    local width, height = self.image:getDimensions()
    local sx, sy        = self.scale, self.scale

    if iso then
        -- Isometric
        cx, cy = UMath:cartesianToIsometric(cx, cy)
        w      = width * sx
        h      = height * sy
        cy     = cy - GRID['cell']['depth'] * GRID['cell']['size'] - 24

        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(self.image, cx-w/2, cy-h, 0, sx, sy)
    else
        -- Cartesian
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill', x, y, w, h)
    end
end

return DLamp