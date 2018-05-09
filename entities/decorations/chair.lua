--=======================================
-- filename:    entities/decorations/plant.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Chair decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Chair      = Decoration:extend()

function Chair:new(x, y, heading)
    self.name  = 'chair'
    self.group = 'decoration'
    self.tags  = { 'chair', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/chair/model_' .. heading .. '.png')
    self.scale  = 0.65
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = true
    self.health       = { now = 2, min = 0, max = 2 }
    self.color        = {32,55,86,255}
end

return Chair