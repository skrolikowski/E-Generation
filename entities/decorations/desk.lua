--=======================================
-- filename:    entities/decorations/desk.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Desk decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Desk       = Decoration:extend()

function Desk:new(x, y)
    self.name  = 'desk'
    self.group = 'decoration'
    self.tags  = { 'desk', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/desk/model.png')
    self.scale  = 0.8
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = false
    self.color        = {80,77,70,255}
end

return Desk