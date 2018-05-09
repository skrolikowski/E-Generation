--=======================================
-- filename:    entities/decorations/toilet.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Toilet decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Toilet     = Decoration:extend()

function Toilet:new(x, y, heading)
    self.name  = 'toilet'
    self.group = 'decoration'
    self.tags  = { 'toilet', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/toilet/model_' .. heading .. '.png')
    self.scale  = 0.65
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = false
    self.color        = {255,255,255,255}
end

return Toilet