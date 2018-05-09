--=======================================
-- filename:    entities/decorations/cabinet.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Cabinet decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Cabinet    = Decoration:extend()

function Cabinet:new(x, y, heading)
    self.name  = 'cabinet'
    self.group = 'decoration'
    self.tags  = { 'cabinet', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/cabinet/model_' .. heading .. '.png')
    self.scale  = 0.65
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = false
    self.color        = {229,136,56,255}
end

return Cabinet