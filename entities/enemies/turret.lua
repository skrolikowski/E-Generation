--=======================================
-- filename:    entities/enemies/turret.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Turret enemy entity.
--=======================================

local Enemy  = require 'entities.enemies.enemy'
local Turret = Enemy:extend()

function Turret:new(x, y, code, active)
    self.name  = 'turret'
    self.group = 'enemy'
    self.tags  = { 'turret', 'enemy', 'immobile' }

    self.pos = Vec2(x, y)
    self.vel = Vec2(0, 0)
    self.acc = Vec2(0, 0)

    self.scale  = 0.6
    self.width  = GRID['cell']['size'] * self.scale
    self.height = GRID['cell']['size'] * self.scale
    self.depth  = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.code         = code
    self.heading      = 1
    self.angle        = ANGLES['sixteenths'][self.heading]
    self.sight        = 200
    self.periphery    = math.pi / 8
    self.mass         = 1
    self.speed        = 1
    self.visible      = true
    self.destructible = false
    self.attack       = 0
    self.health       = { now = 3, min = 0, max = 3 }
    self.color        = {43,185,67,255}

    if active == 'T' then
        self.active   = true
        self.reaction = nil
    else
        self.active   = false
        self.reaction = 'cross'
    end

    -- brain/steering
    self.fsm     = FSM(self, 'idle')
    self.tracker = Tracker(self, controller.spawner, {'player'}, {'door', 'wall','crate'})

    -- force limits
    self.maxSpeed = self.speed
    self.maxForce = 0.25

    self:cell().fillColor = self.color
    self:cell().lineColor = self.color
end

-- ===================================
-- (FSM) Enemy is idle.
-- -------------
-- @return void
-- ===================================
function Turret:idle()
    if self.tracker.target ~= nil then
        self.fsm:pushState('track')
    end
end

-- ===================================
-- (FSM) Enemy is hunting.
-- -------------
-- @return void
-- ===================================
function Turret:track()
    if self.tracker.target ~= nil then
        local lineOfSight   = Vec2():fromAngle(self.angle)
        local vectorBetween = self.tracker.target.pos:copy():sub(self.pos)
        local crossProduct  = vectorBetween:cross(lineOfSight)
        local nearest, idx

        if crossProduct < 0 then
            self.angle = self.angle + 0.01

            if self.angle > math.pi * 2 then
                self.angle = self.angle - math.pi * 2
            end
        elseif crossProduct > 0 then
            self.angle = self.angle - 0.01

            if self.angle < 0 then
                self.angle = self.angle + math.pi * 2
            end
        end

        nearest, idx = UMath:closest(self.angle, ANGLES['sixteenths'])
        self.heading = idx
    else
        self.fsm:popState()
    end
end

-- ===================================
-- Fire at target.
-- -------------
-- @return void
-- ===================================
function Turret:fire()
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
-- Register all event listeners.
-- -------------
-- @return void
-- ===================================
function Turret:registerEvents()
    Event:listen(self, 'switch.triggered', self.trigger)
end

-- ===================================
-- Clear all event listeners.
-- -------------
-- @return void
-- ===================================
function Turret:removeEvents()
    Event:remove('switch.triggered')
end

-- ===================================
-- Turret has been triggered.
-- -------------
-- @param  string code
-- -------------
-- @return void
-- ===================================
function Turret:trigger(code)
    if self.code == code then
        self.active = not self.active
    end
end

-- ===================================
-- One game tick has passed.
-- -------------
-- @param  float dt - time passed
-- -------------
-- @return void
-- ===================================
function Turret:tick(dt)
    if self.tracker.target ~= nil then
        if self.active then
            self:fire()
        end
    else
        self.heading = UMath:mod(self.heading + 1, 16)
        self.angle   = ANGLES['sixteenths'][self.heading]
    end
end

-- ===================================
-- Update the enemy entity.
-- -------------
-- @param float = dt
-- -------------
-- @return void
-- ===================================
function Turret:update(dt)
    self.fsm:update(dt)
    self.tracker:update(dt)
end

-- ===================================
-- Draw the entity.
-- -------------
-- @return void
-- ===================================
function Turret:draw(iso)
    local cx, cy        = self:center()
    local x, y, w, h, d = self:container()
    local width, height = 68, 85
    local sx, sy        = self.scale, self.scale

    if iso then
        -- Isometric
        cx, cy = UMath:cartesianToIsometric(cx, cy)
        w      = width * sx
        h      = height * sy
        cy     = cy - GRID['cell']['depth'] * GRID['cell']['size'] + self.depth

        if self.active then
            love.graphics.setColor(255,255,255,255)
            love.graphics.draw(IMAGE['enemy']['turret'][2], QUAD['enemy']['turret'][self.heading], cx-w/2, cy-h, 0, sx, sy)
        else
            love.graphics.setColor(255,255,255,255)
            love.graphics.draw(IMAGE['enemy']['turret'][1], cx-w/2+8, cy-h/2+5, 0, sx, sy)
        end
    else
        -- Cartesian
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill', x, y, w, h)

        if self.fsm     then self.fsm:draw()     end
        if self.tracker then self.tracker:draw() end
    end
end

return Turret