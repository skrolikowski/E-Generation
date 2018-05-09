--=======================================
-- filename:    entities/decorations/garbage.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Garbage can decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Garbage    = Decoration:extend()

function Garbage:new(x, y, heading)
    self.name  = 'garbage'
    self.group = 'decoration'
    self.tags  = { 'garbage', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/garbage/model_' .. heading .. '.png')
    self.scale  = 0.4
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = true
    self.health       = { now = 2, min = 0, max = 2 }
    self.color        = {77,84,102,255}
end

return Garbage