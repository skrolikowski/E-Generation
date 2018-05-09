--=======================================
-- filename:    map/grid.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Grid cell.
--=======================================

local Object = require 'tools.class'
local Grid   = Object:extend()

function Grid:new(rows, cols)
    self.cells = {}
    self.rows  = rows
    self.cols  = cols

    self:reset()
end

function Grid:reset()
    for i = #self.cells, 1, -1 do
        table.remove(self.cells, i)
    end

    for r = 1, self.rows do
        for c = 1, self.cols do
            table.insert(self.cells, Cell(self, r, c))
        end
    end
end

function Grid:randomCell()
    return UMath:random(self.cells)
end

function Grid:inBounds(row, col)
    return UMath:inRange(row, 0, self.rows + 1) and
           UMath:inRange(col, 0, self.cols + 1)
end

function Grid:getIndex(row, col)
    if self:inBounds(row, col) then
        return ((col - 1) + (row - 1) * self.cols) + 1
    end

    return false
end

function Grid:getCell(row, col)
    local index = self:getIndex(row, col)

    return self.cells[index]
end

function Grid:getIndexByLocation(x, y)
    local row = math.ceil((y - GRID['yOffset']) / GRID['cell']['size'])
    local col = math.ceil((x - GRID['xOffset']) / GRID['cell']['size'])

    return self:getIndex(row, col)
end

function Grid:getCellByLocation(x, y)
    local row = math.ceil((y - GRID['yOffset']) / GRID['cell']['size'])
    local col = math.ceil((x - GRID['xOffset']) / GRID['cell']['size'])

    return self:getCell(row, col)
end

function Grid:getCellsInBounds(x, y, w, h)
    local cells = {}

    for i = x, x + w, GRID['cell']['size'] do
        for j = y, y + h, GRID['cell']['size'] do
            table.insert(cells, self:getCellByLocation(i, j))
        end
    end

    return cells
end

function Grid:update(dt)
    for _, cell in pairs(self.cells) do
        cell:update(dt)
    end
end

function Grid:draw(iso)
    love.graphics.push()
    love.graphics.translate(
        (GRID['xOffset'] or 0),
        (GRID['yOffset'] or 0)
    )

    for _, cell in pairs(self.cells) do
        cell:draw(iso)
    end

    love.graphics.pop()
end

return Grid
