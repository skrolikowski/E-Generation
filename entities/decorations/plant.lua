--=======================================
-- filename:    entities/decorations/plant.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Plant decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Plant      = Decoration:extend()

function Plant:new(x, y)
    self.name  = 'plant'
    self.group = 'decoration'
    self.tags  = { 'plant', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/plant/model.png')
    self.scale  = 0.45
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = true
    self.health       = { now = 2, min = 0, max = 2 }
    self.color        = {158,199,103,255}
end

return Plant