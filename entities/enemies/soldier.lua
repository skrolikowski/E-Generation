--=======================================
-- filename:    entities/enemies/soldier.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Soldier enemy entity.
--=======================================

local Enemy   = require 'entities.enemies.enemy'
local Soldier = Enemy:extend()

local shootImage  = love.graphics.newImage('assets/enemies/soldier/shoot.png')
local patrolImage = love.graphics.newImage('assets/enemies/soldier/patrol.png')

function Soldier:new(x, y, heading)
    self.name  = 'soldier'
    self.group = 'enemy'
    self.tags  = { 'soldier', 'enemy', 'mobile' }

    self.pos  = Vec2(x, y)
    self.vel  = Vec2(0, 0)
    self.acc  = Vec2(0, 0)

    self.image   = patrolImage
    self.quad    = nil
    self.scale   = 0.75
    self.width   = GRID['cell']['size'] * self.scale
    self.height  = GRID['cell']['size'] * self.scale
    self.depth   = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.angle        = ANGLES['headings'][heading]
    self.periphery    = math.pi * 2
    self.sight        = 150
    self.mass         = 1
    self.speed        = 1.5
    self.attack       = 1
    self.destructible = true
    self.health       = { now = 1, min = 0, max = 1 }
    self.color        = {82,60,98,255}

    -- brain/steering
    self.fsm     = FSM(self, 'idle')
    self.steer   = SManager(self)
    self.tracker = Tracker(self, controller.spawner, {'player'}, {'door', 'wall', 'crate'})

    -- force limits
    self.maxSpeed = self.speed
    self.maxForce = 0.25

    -- collision reaction
    self.react  = function(item, other)
        if other.name == 'entrance' or
           other.name == 'exit'
        then
            return 'bounce'
        elseif other.reaction then
            return other.reaction
        end

        return 'bounce'
    end
end

-- ===================================
-- (FSM) Enemy is idle.
-- -------------
-- @return void
-- ===================================
function Soldier:idle()
    self:applyAngleMagnitude(self.angle, self.speed)

    self.fsm:pushState('patrol')
end

-- ===================================
-- (FSM) Enemy is patrolling.
-- -------------
-- @return void
-- ===================================
function Soldier:patrol()
    if self.tracker.target ~= nil then
        self.image      = shootImage
        self.shootTimer = 0

        self.vel:scale(0)
        self.fsm:setState('shoot')
    end
end

-- ===================================
-- (FSM) Enemy is attacking!
-- -------------
-- @return void
-- ===================================
function Soldier:shoot()
    if self.tracker.target == nil then
        self.image = patrolImage
        self.vel:scale(0)

        self.fsm:popState()
    end
end

-- ===================================
-- Fire!
-- -------------
-- @return void
-- ===================================
function Soldier:fire()
    local cx, cy = self:center()
    local nx, ny, photon

    for angle = math.pi / 4, math.pi * 2, math.pi / 4 do
        nx = cx + math.cos(angle) * GRID['cell']['size']
        ny = cy + math.sin(angle) * GRID['cell']['size']

        photon = Photon(nx, ny, angle)
        photon:launch()

        controller.spawner:add(photon)
    end
end

-- ===================================
-- One game tick has passed.
-- -------------
-- @param  float dt - time passed
-- -------------
-- @return void
-- ===================================
function Soldier:tick(dt)
    if self.tracker.target ~= nil then
        self:fire()
    end
end

return Soldier