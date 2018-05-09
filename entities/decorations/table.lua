--=======================================
-- filename:    entities/decorations/table.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Table decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Table      = Decoration:extend()

function Table:new(x, y, heading, accessory)
    self.name  = 'table'
    self.group = 'decoration'
    self.tags  = { 'table', 'decoration' }

    self.pos    = Vec2(x, y)

    if accessory == 'E' then
        self.image = love.graphics.newImage('assets/decorations/table/end_' .. heading .. '.png')
    elseif accessory == 'P' then
        self.image = love.graphics.newImage('assets/decorations/table/middle_plant.png')
    elseif accessory == 'C' then
        self.image = love.graphics.newImage('assets/decorations/table/middle_phone.png')
    else
        self.image = love.graphics.newImage('assets/decorations/table/middle.png')
    end

    self.scale  = 0.85
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = false
    self.color        = {128,112,64,255}
end

return Table