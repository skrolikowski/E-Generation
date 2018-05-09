--=======================================
-- filename:    entities/environments/f_switch.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Floor switch entity.
--=======================================

local Environment = require 'entities.environments.environment'
local FSwitch      = Environment:extend()

function FSwitch:new(x, y, code)
    self.name  = 'fswitch'
    self.group = 'switch'
    self.tags  = { 'fswitch', 'environment' }

    self.pos    = Vec2(x, y)
    self.scale  = 1
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale

    -- attributes
    self.code         = code
    self.occupantMass = 0
    self.massRequired = 1
    self.visible      = false
    self.reaction     = 'cross'

    self.cell           = self:cell()
    self.cell.fillColor = {216,115,175,255}
    self.cell.depth     = GRID['cell']['depth'] + 0.1
end

function FSwitch:trigger(action)
    Event:dispatch('switch.' .. action, self.code)
end

function FSwitch:update(dt)
    if self.occupantMass >= self.massRequired then
        self:trigger('pushed')
        self.cell.fillColor = {66,123,204,255}
        self.cell.depth     = GRID['cell']['depth']
    else
        self:trigger('released')
        self.cell.fillColor = {216,115,175,255}
        self.cell.depth     = GRID['cell']['depth'] + 0.1
    end

    -- reset
    self.occupantMass = 0
end

return FSwitch