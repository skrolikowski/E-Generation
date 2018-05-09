--=======================================
-- filename:    entities/decorations/storage.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Storage decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Storage    = Decoration:extend()

function Storage:new(x, y, heading, corner)
    self.name  = 'storage'
    self.group = 'decoration'
    self.tags  = { 'storage', 'decoration' }

    self.pos  = Vec2(x, y)

    if corner == 'T' then
        self.image  = love.graphics.newImage('assets/decorations/storage/corner_' .. heading .. '.png')
    else
        self.image  = love.graphics.newImage('assets/decorations/storage/model_' .. heading .. '.png')
    end

    self.scale  = 0.9
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = false
    self.color        = {59,26,7,255}
end

return Storage