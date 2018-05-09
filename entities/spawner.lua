--=======================================
-- filename:    entities/spawner.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Entity spawner.
--=======================================

local Object  = require 'tools.class'
local Spawner = Object:extend()

function Spawner:new()
    self.world = Bump.newWorld(GRID['cell']['size'])
end

-- ===================================
-- Reset the world.
-- -------------
-- @return void
-- ===================================
function Spawner:reset()
    local entities, len = self.world:getItems()

    for i = #entities, 1, -1 do
        self:remove(entities[i])
    end
end

-- ===================================
-- Get all entities by name.
-- -------------
-- @param name - entity name
-- -------------
-- @return table
-- ===================================
function Spawner:getEntities(name)
    local entities, len = self.world:getItems()
    local matches = {}

    for _, entity in pairs(entities) do
        if entity.name and entity.name == name then
            table.insert(matches, entity)
        end
    end

    return matches
end

-- ===================================
-- Get all entities by tag.
-- -------------
-- @param tags - entity name
-- -------------
-- @return table
-- ===================================
function Spawner:getEntitiesByTag(tags)
    local entities, len = self.world:getItems()
    local matches = {}

    for _, entity in pairs(entities) do
        intersect = UTable:intersect(entity.tags, tags)

        if #intersect > 0 then
            table.insert(matches, entity)
        end
    end

    return matches
end

-- ===================================
-- Query cell location for entities.
-- -------------
-- @param Cell     cell
-- @param function filter (optional)
-- -------------
-- @return table, int
-- ===================================
function Spawner:queryRect(x, y, w, h, filter)
    return self.world:queryRect(x, y, w, h, filter)
end

-- ===================================
-- Query cell location for entities.
-- -------------
-- @param Cell     cell
-- @param function filter (optional)
-- -------------
-- @return table, int
-- ===================================
function Spawner:queryCell(cell, filter)
    local x, y, w, h = cell:container()

    return self.world:queryRect(x, y, w, h, filter)
end

-- ===================================
-- Attempt to move entity to next position
-- -------------
-- @param entity
-- @param nextPos - next position
-- -------------
-- @return void
-- ===================================
function Spawner:move(entity, nextPos)
    if not self.world:hasItem(entity) then
        return
    end

    local wX, wY          = self:convertToWorldPosition(entity, nextPos.x, nextPos.y)
    local x, y, cols, len = self.world:move(entity, wX, wY, entity.react)
    local eX, eY          = self:convertToEntityPosition(entity, x, y)

    -- update position
    entity.pos = Vec2(eX, eY)

    if len > 0 then
        for _, col in pairs(cols) do
            entity:collidedWith(col.other, col)
        end
    end
end

-- ===================================
-- Change center position of entity to
--  top-left position.
-- -------------
-- @param entity
-- @param x
-- @param y
-- -------------
-- @return float, float
-- ===================================
function Spawner:convertToWorldPosition(entity, x, y)
    local x = x - entity.width / 2
    local y = y - entity.height / 2

    return x, y
end

-- ===================================
-- Change top-left position of entity
--  to center position.
-- -------------
-- @param entity
-- @param x
-- @param y
-- -------------
-- @return float, float
-- ===================================
function Spawner:convertToEntityPosition(entity, x, y)
    local x = x + entity.width / 2
    local y = y + entity.height / 2

    return x, y
end

-- ===================================
-- Add multiple entities.
-- -------------
-- @param ... - entities
-- -------------
-- @return void
-- ===================================
function Spawner:addEntities(...)
    for _, entity in pairs({...}) do
        self:add(entity)
    end
end

-- ===================================
-- Add entity to world.
-- -------------
-- @param entity
-- -------------
-- @return void
-- ===================================
function Spawner:add(entity)
    entity:registerEvents()

    self.world:add(entity, entity:container())
end

-- ===================================
-- Remove entity from world.
-- -------------
-- @param entity
-- -------------
-- @return void
-- ===================================
function Spawner:remove(entity)
    if not self.world:hasItem(entity) then
        return
    end

    entity:removeEvents()
    self.world:remove(entity)
end

-- ===================================
-- Reorder entities for zOrder depth.
-- -------------
-- @return table, int
-- ===================================
function Spawner:zOrder()
    local entities, len = self.world:getItems()

    table.sort(entities,
        function(e1, e2)
            local e1x, e1y = e1:center()
            local e1z      = e1x + e1y
            local e2x, e2y = e2:center()
            local e2z      = e2x + e2y

            return e1z < e2z
        end
    )

    return entities, len
end

-- ===================================
-- One game tick has passed.
-- Notify all entities.
-- -------------
-- @param dt - tick amount
-- -------------
-- @return void
-- ===================================
function Spawner:tick(dt)
    local entities, len = self.world:getItems()

    for _, entity in pairs(entities) do
        entity:tick(dt)
    end
end

-- ===================================
-- Update entity objects.
-- -------------
-- @param dt - time passed
-- -------------
-- @return void
-- ===================================
function Spawner:update(dt)
    local entities, len = self.world:getItems()

    for _, entity in pairs(entities) do
        entity:update(dt)
    end
end

-- ===================================
-- Draw entity objects.
-- -------------
-- @return void
-- ===================================
function Spawner:draw(iso)
    local entities, len = self:zOrder()

    for _, entity in pairs(entities) do
        entity:draw(iso)
    end
end

return Spawner
