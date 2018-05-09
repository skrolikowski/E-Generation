--=======================================
-- filename:    entities/environments/wall.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Wall entity.
--=======================================

local Environment = require 'entities.environments.environment'
local Wall        = Environment:extend()

function Wall:new(x, y, depth, switchHeading, switchCode, accessory)
    self.name    = 'wall'
    self.group   = 'barrier'
    self.tags    = { 'wall', 'environment' }
    self.visible = true

    self.pos     = Vec2(x, y)
    self.width   = GRID['cell']['size']
    self.height  = GRID['cell']['size']
    self.depth   = depth or 1
    self.window  = (accessory == 'T')
    self.colors  = self:cell().colors

    -- switch
    if accessory == '0' then
        self.pressed   = nil
        self.triggered = false
        self.switch    = true
        self.heading   = ANGLES['headings'][switchHeading]
        self.code      = switchCode
        self.color     = {255,209,109,255}
    end

    -- impassable
    self:cell().weight = nil
end

function Wall:trigger()
    if not self.triggered then
        self.triggered = true

        Event:dispatch('switch.triggered', self.code)
    end
end

function Wall:update(dt)
    if self.switch then
        if self.pressed ~= nil and self.pressed == self.heading then
            self:trigger()
        else
            self.triggered = false
        end

        -- reset
        self.pressed = nil
    end
end

function Wall:draw(iso)
    local x, y, w, h, d = self:container()

    if iso then
        -- Isometric
        x1, y1, w1, h1 = UMath:cartesianToIsometric(x, y, w, h)
        y1             = y1 - GRID['cell']['depth'] * GRID['cell']['size']

        love.graphics.push()
        love.graphics.translate(x1, y1)

        if self.window then
            self:drawIsoShape(x1, y1, w1, h1, 1, self.colors)
        else
            self:drawIsoShape(x1, y1, w1, h1, d, self.colors)
        end

        if self.switch then
            if self.heading == math.pi / 2 then
                love.graphics.setColor(self.color)
                love.graphics.polygon('fill',
                    -w1/2, h1/2 - 1 * h1,
                    0, h - 1 * h1,
                    -w1/4, h1/4
                )
            elseif self.heading == 0 then
                love.graphics.setColor(self.color)
                love.graphics.polygon('fill',
                    w1/2, h1/2 - 1 * h1,
                    0, h1 - 1 * h1,
                    w1/4, h1/4
                )
            end
        end

        love.graphics.pop()

        if self.window and self.depth >= 4 then
            x2, y2, w2, h2 = UMath:cartesianToIsometric(x, y, w, h)
            y2             = y2 - (GRID['cell']['depth'] + 3) * GRID['cell']['size']

            love.graphics.push()
            love.graphics.translate(x2, y2)

            self:drawIsoShape(x2, y2, w2, h2, d - 3, self.colors)

            love.graphics.pop()
        end
    else
        -- Cartesian
        love.graphics.setColor(self.colors[1])
        love.graphics.rectangle('fill', x, y, w, h)
    end
end

return Wall