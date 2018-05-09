--=======================================
-- filename:    entities/environement/teleporter.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Teleporter entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Teleporter       = Decoration:extend()

function Teleporter:new(x, y)
    self.name  = 'teleporter'
    self.group = 'transport'
    self.tags  = { 'teleporter', 'environement' }

    self.pos       = Vec2(x, y)
    self.image     = love.graphics.newImage('assets/environments/teleporter/model.png')
    self.scale     = 0.85
    self.width     = GRID['cell']['size'] * self.scale
    self.height    = GRID['cell']['size'] * self.scale
    self.depth     = GRID['cell']['size'] / 2 * self.scale
    self.color     = {255,255,255,255}
    self.reaction  = 'cross'
end

function Teleporter:draw(iso)
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

return Teleporter