--=======================================
-- filename:    entities/environments/entrance.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Entrance entity.
--=======================================

local Environment = require 'entities.environments.environment'
local Entrance    = Environment:extend()

function Entrance:new(x, y, roomIndex)
    self.name      = 'entrance'
    self.group     = 'transport'
    self.tags      = { 'entrance', 'environment' }
    self.visible   = false
    self.roomIndex = roomIndex
    self.pos       = Vec2(x, y)
    self.width     = GRID['cell']['size']
    self.height    = GRID['cell']['size']
    self.depth     = 0
    self.reaction  = 'cross'

    -- impassable
    self:cell().weight = nil

    if roomIndex == controller.spawn then
        controller.spawner:add(Player(x, y, 1))
    end
end

return Entrance