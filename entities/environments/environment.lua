--=======================================
-- filename:    entities/environments/environment.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Environment object.
--=======================================

local Entity      = require 'entities.entity'
local Environment = Entity:extend()

function Environment:draw(iso)
    local x, y, w, h, d = self:container()

    if self.visible then
        if iso then
            -- Isometric
            x, y, w, h = UMath:cartesianToIsometric(x, y, w, h)
            y          = y - GRID['cell']['depth'] * GRID['cell']['size']

            love.graphics.push()
            love.graphics.translate(x, y)

            self:drawIsoShape(x, y, w, h, d, self.colors)

            love.graphics.pop()
        else
            -- Cartesian
            love.graphics.setColor(self.colors[1])
            love.graphics.rectangle('fill', x, y, w, h)
        end
    end
end

return Environment