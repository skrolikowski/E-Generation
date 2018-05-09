--=======================================
-- filename:    entities/decorations/bookshelf.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Bookshelf decoration entity.
--=======================================

local Decoration = require 'entities.decorations.decoration'
local Bookshelf      = Decoration:extend()

function Bookshelf:new(x, y, heading)
    self.name  = 'bookshelf'
    self.group = 'decoration'
    self.tags  = { 'bookshelf', 'decoration' }

    self.pos    = Vec2(x, y)
    self.image  = love.graphics.newImage('assets/decorations/bookshelf/model_' .. heading .. '.png')
    self.scale  = 0.9
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.destructible = false
    self.color        = {32,55,86,255}
end

return Bookshelf