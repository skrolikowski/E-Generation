--=======================================
-- filename:    entities/decorations/oven.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Oven decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Oven    = Decoration:extend()

function Oven:new(x, y, heading)
    self.name  = 'oven'
    self.group = 'decoration'
    self.tags  = { 'oven', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/oven/model_' .. heading .. '.png')
    self.scale  = 0.9
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = false
    self.color        = {255,255,255,255}
end

return Oven