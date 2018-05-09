--=======================================
-- filename:    entities/decorations/fridge.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Fridge decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Fridge     = Decoration:extend()

function Fridge:new(x, y, heading)
    self.name  = 'fridge'
    self.group = 'decoration'
    self.tags  = { 'fridge', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/fridge/model_' .. heading .. '.png')
    self.scale  = 0.9
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = false
    self.color        = {255,255,255,255}
end

return Fridge