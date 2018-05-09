--=======================================
-- filename:    map/cell.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Grid cell.
--=======================================
local Object = require 'tools.class'
local Cell   = Object:extend()

function Cell:new(grid, row, col)
    self.grid    = grid
    self.name    = row .. ',' .. col
    self.row     = row
    self.col     = col
    self.visible = true
    self.depth   = GRID['cell']['depth']
    self.colors  = UTable:copy(UI['color']['scheme'][GRID['colors']])

    -- Pathfinding
    self.weight = 1   -- difficulty crossing cell
    self.hScore = 0   -- distance to end node
    self.gScore = 0   -- distance from starting node
end

function Cell:index()
    return ((self.col - 1) + (self.row - 1) * self.grid.cols) + 1
end

function Cell:center()
    local x, y = self:position()

    x = x + GRID['cell']['size'] / 2
    y = y + GRID['cell']['size'] / 2

    return x, y
end

function Cell:position()
    local x = (self.col - 1) * GRID['cell']['size'] + (GRID['cell']['padding'] or 0) + (GRID['xOffset'] or 0)
    local y = (self.row - 1) * GRID['cell']['size'] + (GRID['cell']['padding'] or 0) + (GRID['xOffset'] or 0)

    return x, y
end

function Cell:container()
    local x, y = self:position()
    local w    = GRID['cell']['size'] - GRID['cell']['padding']
    local h    = GRID['cell']['size'] - GRID['cell']['padding']
    local d    = self.depth

    return x, y, w, h, d
end

function Cell:distance(other)
    return math.abs(self.row - other.row) + math.abs(self.col - other.col)
end

function Cell:passible()
    return self.weight ~= nil
end

--=======================================
-- Get adjacent neighboring cells
--  (including diagonals).
-- ----------
-- @return table
--=======================================
function Cell:edges()
    local edges = {}
    local row, col, cell

    for r = -1, 1 do
        for c = -1, 1 do
            if r == 0 and c == 0 then
                -- ...
            else
                row  = self.row + r
                col  = self.col + c
                cell = self.grid:getCell(row, col)

                if self.grid:inBounds(row, col) and cell:passible() then
                    table.insert(edges, cell)
                end
            end
        end
    end

    return edges
end

--=======================================
-- Get adjacent neighboring cells
-- Order: up, right, down, left
-- ----------
-- @return table
--=======================================
function Cell:getNeighbors()
    local directions = {{-1,0},{0,1},{1,0},{0,-1}}
    local neighbors  = {}
    local row, col, cell

    for i = 1, #directions do
        row  = self.row + directions[i][1]
        col  = self.col + directions[i][2]
        cell = self.grid:getCell(row, col)

        if self.grid:inBounds(row, col) and cell:passible() then
            table.insert(neighbors, cell)
        end
    end

    return neighbors
end

function Cell:update(dt)
    --
end

function Cell:drawIsoShape(x, y, w, h, d)
    -- top
    love.graphics.setColor(self.colors[1])
    love.graphics.polygon('fill',
        0, -d * h,
        w/2, h/2 - d * h,
        0, h - d * h,
        -w/2, h/2 - d * h
    )

    love.graphics.setColor(self.colors[4])
    love.graphics.setLineWidth(1)
    love.graphics.polygon('line',
        0, -d * h,
        w/2, h/2 - d * h,
        0, h - d * h,
        -w/2, h/2 - d * h
    )

    -- left
    love.graphics.setColor(self.colors[2])
    love.graphics.polygon('fill',
        -w/2, h/2 - d * h,
        0, h - d * h,
        0, h,
        -w/2, h/2
    )

    -- right
    love.graphics.setColor(self.colors[3])
    love.graphics.polygon('fill',
        w/2, h/2 - d * h,
        0, h - d * h,
        0, h,
        w/2, h/2
    )
end

function Cell:draw(iso)
    local x, y, w, h, d = self:container()

    if self.visible then
        if iso then
            -- Isometric
            x, y, w, h = UMath:cartesianToIsometric(x, y, w, h)

            love.graphics.push()
            love.graphics.translate(x, y)

            self:drawIsoShape(x, y, w, h, d)

            love.graphics.pop()
        else
            -- Cartesian
            if self:passible() then
                love.graphics.setColor(self.fillColor)
                love.graphics.rectangle('fill', x, y, w, h)

                love.graphics.setColor(self.lineColor)
                love.graphics.setLineWidth(1)
                love.graphics.rectangle('line', x, y, w, h)
            else
                love.graphics.setColor(self.fillColor)
                love.graphics.rectangle('fill', x, y, w, h)
            end
        end
    end
end

return Cell
