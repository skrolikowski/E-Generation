--=======================================
-- filename:    entities/decorations/couch.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Couch decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Couch      = Decoration:extend()

function Couch:new(x, y, heading, corner)
    self.name  = 'couch'
    self.group = 'decoration'
    self.tags  = { 'couch', 'decoration' }

    if corner == 'T' then
        self.image  = love.graphics.newImage('assets/decorations/couch/corner_' .. heading .. '.png')
    else
        self.image  = love.graphics.newImage('assets/decorations/couch/model_' .. heading .. '.png')
    end

    self.pos    = Vec2(x, y)
    self.scale  = 0.85
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = true
    self.health       = { now = 3, min = 0, max = 3 }
    self.color        = {90,131,53,255}
end

return Couch