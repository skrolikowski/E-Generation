--=======================================
-- filename:    entities/environments/exit.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Exit entity.
--=======================================

local Environment = require 'entities.environments.environment'
local Exit        = Environment:extend()

function Exit:new(x, y, roomIndex)
    self.name      = 'exit'
    self.group     = 'transport'
    self.tags      = { 'exit', 'environment' }
    self.visible   = false
    self.roomIndex = roomIndex
    self.pos       = Vec2(x, y)
    self.width     = GRID['cell']['size']
    self.height    = GRID['cell']['size']
    self.depth     = 0
    self.reaction  = 'cross'

    self.cell = self:cell()
    self.cell.fillColor = {165,38,47,255}
    self.cell.weight = nil
end

return Exit