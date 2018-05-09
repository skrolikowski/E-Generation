--=======================================
-- filename:    entities/enemies/launcher.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Wall launcher enemy entity.
--=======================================

local Enemy    = require 'entities.enemies.enemy'
local Launcher = Enemy:extend()

function Launcher:new(x, y, heading, delay)
    self.name  = 'launcher'
    self.group = 'enemy'
    self.tags  = { 'launcher', 'enemy', 'immobile' }

    self.pos    = Vec2(x, y)
    self.width  = GRID['cell']['size']
    self.height = GRID['cell']['size']
    self.depth  = GRID['cell']['size']

    -- image
    self.image  = love.graphics.newImage('assets/enemies/launcher/model_' .. heading .. '.png')
    self.imageS = 0.75
    self.imageW = self.image:getWidth() * self.imageS
    self.imageH = self.image:getHeight() * self.imageS

    -- attributes
    self.fireTimer    = 0
    self.delay        = tonumber(delay)
    self.heading      = heading
    self.angle        = ANGLES['headings'][heading]
    self.active       = true
    self.visible      = true
    self.destructible = false
    self.reaction     = 'cross'
    self.color        = {102,0,51,255}
end

-- ===================================
-- Fire at target.
-- -------------
-- @return void
-- ===================================
function Launcher:fire()
    local cx, cy = self:center()
    local nx     = cx + math.cos(self.angle) * GRID['cell']['size']
    local ny     = cy + math.sin(self.angle) * GRID['cell']['size']
    local photon

    photon = Photon(nx, ny, self.angle)
    photon:launch()

    -- AUDIO['particle'][2]:play()
    -- AUDIO['particle'][2]:rewind()

    controller.spawner:add(photon)
end

-- ===================================
-- Update the enemy entity.
-- -------------
-- @param float = dt
-- -------------
-- @return void
-- ===================================
function Launcher:update(dt)
    self.fireTimer = self.fireTimer + dt

    if self.fireTimer >= self.delay then
        self:fire()
        self.fireTimer = 0
    end
end

-- ===================================
-- Draw the entity.
-- -------------
-- @return void
-- ===================================
function Launcher:draw(iso)
    local cx, cy        = self:center()
    local x, y, w, h, d = self:container()

    if iso then
        -- Isometric
        cx, cy = UMath:cartesianToIsometric(cx, cy)
        cy     = cy - GRID['cell']['depth'] * GRID['cell']['size'] - self.depth

        if self.heading == 'N' or self.heading == 'S' then
            cx = cx + GRID['cell']['size'] / 2
        else
            cx = cx - GRID['cell']['size'] / 2
        end

        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(self.image, cx - self.imageW / 2, cy - self.imageH, 0, self.imageS, self.imageS)
    else
        -- Cartesian
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill', x, y, w, h)
    end
end

return Launcher