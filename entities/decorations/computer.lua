--=======================================
-- filename:    entities/decorations/computer.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Computer decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Computer   = Decoration:extend()

function Computer:new(x, y, heading)
    self.name  = 'computer'
    self.group = 'decoration'
    self.tags  = { 'computer', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/computer/model_' .. heading .. '.png')
    self.scale  = 0.6
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale

    -- attributes
    self.destructible = true
    self.health       = { now = 1, min = 0, max = 1 }
    self.color        = {226,208,162,255}
end

function Computer:draw(iso)
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

return Computer