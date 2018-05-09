--=======================================
-- filename:    entities/decorations/watercooler.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Watercooler decoration entity.
--=======================================

local Decoration  = require 'entities.decorations.decoration'
local Watercooler = Decoration:extend()

function Watercooler:new(x, y, heading)
    self.name  = 'watercooler'
    self.group = 'decoration'
    self.tags  = { 'watercooler', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/watercooler/model_' .. heading .. '.png')
    self.scale  = 0.65
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = true
    self.health       = { now = 3, min = 0, max = 3 }
    self.color        = {190,241,245,255}
end

return Watercooler