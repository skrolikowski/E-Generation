--=======================================
-- filename:    controller.lua
-- author:      Shane Krolikowski
-- created:     Jan, 2018
-- description: Game controller.
--=======================================

local Object     = require 'tools.class'
local Controller = Object:extend()

function Controller:new()
    self.floor   = 1
    self.room    = '001'
    self.spawn   = '000'
    self.grid    = Grid(GRID['rows'], GRID['cols'])
    self.spawner = Spawner()
    self.timer   = Timer.new()

    self.timer:every(GAME['tick'], function() self:tick(GAME['tick']) end)
end

-- ===================================
-- Reset controller.
-- -------------
-- @return void
-- ===================================
function Controller:reset()
    self.grid:reset()
    self.spawner:reset()

    self.timer:clear()
    self.timer:every(GAME['tick'], function() self:tick(GAME['tick']) end)
end

function Controller:reloadRoom()
    self:reset()
    self:loadRoom(self.floor, self.room)
end

-- ===================================
-- Set spawn point if player dies.
-- -------------
-- @return void
-- ===================================
function Controller:setSpawn(roomIndex)
    self.spawn = roomIndex
end

-- ===================================
-- Load room data.
-- -------------
-- @param int  floor number
-- @param int  room number
-- -------------
-- @return void
-- ===================================
function Controller:loadRoom(floor, room)
    local elements = ROOMS[tonumber(room)]
    local index, code

    self.floor = floor
    self.room  = room

    for _, cell in pairs(self.grid.cells) do
        index  = string.sub(elements[cell.row][cell.col], 1, 1)
        code   = string.sub(elements[cell.row][cell.col], 2, 4)

        if index == '_' then
            self:loadDecoration(cell, code)
        elseif index == '-' then
            self:loadEnemy(cell, code)
        elseif index == '+' then
            self:loadUnit(cell, code)
        else
            self:loadEnvironment(cell, elements[cell.row][cell.col])
        end
    end
end

function Controller:loadDecoration(cell, code)
    local cx, cy = cell:center()
    local index  = string.sub(code, 1, 1)

    if index == 'D' then
        self.spawner:add(Desk(cx, cy))

        if string.sub(code, 2, 2) == 'C' then
            self.spawner:add(Computer(cx+1, cy+1, string.sub(code, 3, 3)))
        elseif string.sub(code, 2, 2) == 'L' then
            self.spawner:add(DLamp(cx+1, cy+1, string.sub(code, 3, 3)))
        elseif string.sub(code, 2, 2) == 'B' then
            self.spawner:add(Books(cx+1, cy+1, string.sub(code, 3, 3)))
        end
    elseif index == 'B' then
        self.spawner:add(Bookshelf(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'C' then
        self.spawner:add(Chair(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'P' then
        self.spawner:add(Plant(cx, cy))
    elseif index == 'F' then
        self.spawner:add(Fridge(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'L' then
        self.spawner:add(FLamp(cx, cy))
    elseif index == 'W' then
        self.spawner:add(Watercooler(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'G' then
        self.spawner:add(Garbage(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'A' then
        self.spawner:add(Cabinet(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'O' then
        self.spawner:add(Couch(cx, cy, string.sub(code, 2, 2), string.sub(code, 3, 3)))
    elseif index == 'V' then
        self.spawner:add(Oven(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'U' then
        self.spawner:add(Counter(cx, cy, string.sub(code, 2, 2), string.sub(code, 3, 3)))
    elseif index == 'T' then
        self.spawner:add(Table(cx, cy, string.sub(code, 2, 2), string.sub(code, 3, 3)))
    elseif index == 'E' then
        self.spawner:add(Toilet(cx, cy, string.sub(code, 2, 2)))
    end
end

function Controller:loadEnemy(cell, code)
    local cx, cy = cell:center()
    local index  = string.sub(code, 1, 1)

    if index == 'C' then
        self.spawner:add(Chaser(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'L' then
        self.spawner:add(Launcher(cx, cy, string.sub(code, 2, 2), string.sub(code, 3, 3)))
    elseif index == 'O' then
        self.spawner:add(Oracle(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'S' then
        self.spawner:add(Soldier(cx, cy, string.sub(code, 2, 2)))
    elseif index == 'T' then
        self.spawner:add(Turret(cx, cy, string.sub(code, 2, 2), string.sub(code, 3, 3)))
    elseif index == 'Z' then
        self.spawner:add(Zapper(cx, cy, string.sub(code, 2, 2), string.sub(code, 3, 3)))
    end
end

function Controller:loadUnit(cell, code)
    local cx, cy = cell:center()
    local index  = string.sub(code, 1, 1)

    if index == 'C' then
        -- civilian
    end
end

function Controller:loadEnvironment(cell, code)
    local cx, cy = cell:center()
    local index  = string.sub(code, 1, 1)

    if code == 'XXXX' then
        cell.visible = false
        cell.weight  = nil
    elseif index == 'F' then
        -- todo cell color override
    elseif index == 'A' then
        self.spawner:add(Arrow(cx, cy, string.sub(code, 2, 2), string.sub(code, 3, 3)))
    elseif index == 'C' then
        self.spawner:add(Crate(cx, cy))
    elseif index == 'T' then
        self.spawner:add(Teleporter(cx, cy))
    elseif index == 'E' then
        self.spawner:add(Elevator(cx, cy, string.sub(code, 4, 4)))
    elseif index == 'V' then
        self.spawner:add(Vent(cx, cy, string.sub(code, 2, 2), string.sub(code, 3, 3)))
    elseif index == 'I' then
        self.spawner:add(Entrance(cx, cy, string.sub(code, 2, 4)))
    elseif index == 'O' then
        self.spawner:add(Exit(cx, cy, string.sub(code, 2, 4)))
    elseif index == 'D' then
        self.spawner:add(Door(cx, cy, string.sub(code, 2, 2), string.sub(code, 3, 3), string.sub(code, 4, 4)))
    elseif index == 'S' then
        self.spawner:add(FSwitch(cx, cy, string.sub(code, 2, 2)))
    elseif tonumber(index) ~= nil then
        self.spawner:add(Wall(cx, cy, tonumber(index), string.sub(code, 2, 2), string.sub(code, 3, 3), string.sub(code, 4, 4)))
    end
end

function Controller:tick(dt)
    self.spawner:tick(dt)
end

-- ===================================
-- Update world objects.
-- -------------
-- @param dt - time passed
-- -------------
-- @return void
-- ===================================
function Controller:update(dt)
    self.spawner:update(dt)
    self.timer:update(dt)
end

-- ===================================
-- Draw world objects.
-- -------------
-- @return void
-- ===================================
function Controller:draw()
    love.graphics.setColor(255,255,255,255)
    love.graphics.printf('FPS: ' .. love.timer.getFPS(), 0, 25, WORLD['width'] - 25, 'right')

    if GAME['debug'] then
        love.graphics.push()
        love.graphics.translate(0, 0)

        self.grid:draw(false)
        self.spawner:draw(false)

        love.graphics.pop()

        ----

        love.graphics.push()
        love.graphics.translate(WORLD['width'] / 2, WORLD['height'] - 250)

        self.grid:draw(true)
        self.spawner:draw(true)

        love.graphics.pop()
    else
        love.graphics.push()
        love.graphics.translate(WORLD['width'] / 2, WORLD['height'] - 200)

        self.grid:draw(true)
        self.spawner:draw(true)

        love.graphics.pop()
    end
end

return Controller