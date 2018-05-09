--=======================================
-- filename:    entities/decorations/f_lamp.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Floor lamp decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local FLamp      = Decoration:extend()

function FLamp:new(x, y)
    self.name  = 'f_lamp'
    self.group = 'decoration'
    self.tags  = { 'f_lamp', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/floor lamp/model.png')
    self.scale  = 0.85
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = true
    self.health       = { now = 3, min = 0, max = 3 }
    self.color        = {253,223,47}
end

return FLamp