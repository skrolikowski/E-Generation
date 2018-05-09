--=======================================
-- filename:    entities/enemies/zapper.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Zapper enemy entity.
--=======================================

local Enemy  = require 'entities.enemies.enemy'
local Zapper = Enemy:extend()

function Zapper:new(x, y, delayOff, delayOn)
    self.name   = 'zapper'
    self.group  = 'enemy'
    self.tags   = { 'zapper', 'enemy' }

    self.pos    = Vec2(x, y)
    self.scale  = 1
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale

    -- attributes
    self.attack       = 5
    self.active       = true
    self.action       = self.poweringOff
    self.actionTicks  = { off = tonumber(delayOff), on = tonumber(delayOn) }
    self.actionTimer  = 0
    self.destructible = false
    self.reaction     = 'cross'

    -- colors!
    self.colorTimer  = 0
    self.colorDelay  = 0.25
    self.colors      = {
        {229,85,144,255},
        {127,187,55,255},
        {79,211,250,255},
    }
end

-- ===================================
-- Tile is powering on.
-- -------------
-- @param float = tick
-- -------------
-- @return void
-- ===================================
function Zapper:poweringOn(tick)
    self.actionTimer = self.actionTimer + tick

    if self.actionTimer >= self.actionTicks.on then
        self.active      = true
        self.action      = self.poweringOff
        self.actionTimer = 0
    end
end

-- ===================================
-- Tile is powering off.
-- -------------
-- @param float = tick
-- -------------
-- @return void
-- ===================================
function Zapper:poweringOff(tick)
    self.actionTimer = self.actionTimer + tick

    if self.actionTimer >= self.actionTicks.off then
        self.active      = false
        self.action      = self.poweringOn
        self.actionTimer = 0
    end
end

-- ===================================
-- Update the enemy entity.
-- -------------
-- @param float = dt
-- -------------
-- @return void
-- ===================================
function Zapper:update(dt)
    self.colorTimer = self.colorTimer + dt

    if self.colorTimer >= self.colorDelay then
        self.colorTimer = 0
        self.colors     = UTable:wrap(self.colors, 1)
    end

    self.action(self, dt)
end

-- ===================================
-- Draw the entity.
-- -------------
-- @return void
-- ===================================
function Zapper:draw(iso)
    local x, y, w, h = self:container()

    if self.active then
        if iso then
            -- Isometric
            for i = 1 , #self.colors do
                self:drawIsoShape(
                    x + (i * 5),
                    y + (i * 5),
                    w - (i * 10),
                    h - (i * 10),
                    self.colors[i]
                )
            end
        else
            -- Cartesian
            love.graphics.setColor(self.colors[1])
            love.graphics.rectangle('fill', x, y, w, h)
        end
    end
end

function Zapper:drawIsoShape(x, y, w, h, color)
    x, y, w, h = UMath:cartesianToIsometric(x, y, w, h)
    y          = y - GRID['cell']['depth'] * GRID['cell']['size']

    love.graphics.setColor(color)
    love.graphics.setLineWidth(10)
    love.graphics.polygon('line',
        x, y,            -- TL
        x+w/2, y+h/2,    -- TR
        x, y+h,          -- BR
        x-w/2, y+h/2     -- BL
    )
end

return Zapper