--=======================================
-- filename:    entities/enemies/chaser.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Chaser enemy entity.
--=======================================

local Enemy  = require 'entities.enemies.enemy'
local Chaser = Enemy:extend()

local chaseImage  = love.graphics.newImage('assets/enemies/chaser/chase.png')
local patrolImage = love.graphics.newImage('assets/enemies/chaser/patrol.png')

function Chaser:new(x, y, heading)
    self.name  = 'chaser'
    self.group = 'enemy'
    self.tags  = { 'chaser', 'enemy', 'mobile' }

    self.pos = Vec2(x, y)
    self.vel = Vec2(0, 0)
    self.acc = Vec2(0, 0)

    self.image   = patrolImage
    self.scale   = 0.75
    self.width   = GRID['cell']['size'] * self.scale
    self.height  = GRID['cell']['size'] * self.scale
    self.depth   = GRID['cell']['size'] / 2 * self.scale

    -- attributes
    self.angle        = ANGLES['headings'][heading]
    self.periphery    = math.pi * 2
    self.sight        = 150
    self.mass         = 1
    self.attack       = 1
    self.speed        = 1
    self.destructible = true
    self.health       = { now = 1, min = 0, max = 1 }
    self.color        = {82,60,98,255}

    -- brain/steering
    self.fsm     = FSM(self, 'idle')
    self.steer   = SManager(self)
    self.tracker = Tracker(self, controller.spawner, {'player'}, {'door', 'wall', 'crate'})
    self.path    = nil

    -- force limits
    self.maxSpeed = 2
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
function Chaser:idle()
    self:applyAngleMagnitude(self.angle, self.speed)

    self.fsm:pushState('patrol')
end

-- ===================================
-- (FSM) Enemy is patrolling.
-- -------------
-- @return void
-- ===================================
function Chaser:patrol()
    if self.tracker.target ~= nil then
        self.speed = self.maxSpeed
        self.image = chaseImage

        self.fsm:setState('chase')
    end
end

-- ===================================
-- (FSM) Enemy is chasing.
-- -------------
-- @return void
-- ===================================
function Chaser:chase()
    local finished = false
    local start, goal

    if self.tracker.target ~= nil then
        start     = self:cell()
        goal      = self.tracker.target:cell()
        self.path = PathFinder:newPath(start, goal, 5)

        self.steer:follow(self.path)

        if self.path:isFinished(self) then
            finished = true
        end
    else
        finished = true
    end

    if finished then
        self.speed = 1
        self.path  = nil
        self.image = patrolImage

        self.vel:scale(0)
        self.fsm:popState()
    end
end

return Chaser