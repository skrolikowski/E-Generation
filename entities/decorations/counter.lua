--=======================================
-- filename:    entities/decorations/counter.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Counter decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Counter    = Decoration:extend()

function Counter:new(x, y, heading, version)
    self.name  = 'counter'
    self.group = 'decoration'
    self.tags  = { 'counter', 'decoration' }

    self.pos = Vec2(x, y)

    if version == 'C' then
        self.image  = love.graphics.newImage('assets/decorations/counter/cabinet_' .. heading .. '.png')
    elseif version == 'S' then
        self.image  = love.graphics.newImage('assets/decorations/counter/sink_' .. heading .. '.png')
    elseif version == 'T' then
        self.image  = love.graphics.newImage('assets/decorations/counter/cabinet_sink_' .. heading .. '.png')
    elseif version == 'X' then
        self.image  = love.graphics.newImage('assets/decorations/counter/cabinet_corner_' .. heading .. '.png')
    else
        self.image  = love.graphics.newImage('assets/decorations/counter/model_' .. heading .. '.png')
    end

    self.scale  = 0.9
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = false
    self.color        = {59,26,7,255}
end

return Counter