--=======================================
-- filename:    entities/environments/arrow.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Arrow entity.
--=======================================

local Environment = require 'entities.environments.environment'
local Arrow       = Environment:extend()

function Arrow:new(x, y, depth, heading)
    self.name    = 'arrow'
    self.tags    = { 'arrow', 'environment' }
    self.pos     = Vec2(x, y)
    self.width   = GRID['cell']['size']
    self.height  = GRID['cell']['size']
    self.depth   = GRID['cell']['size'] * depth

    -- image
    self.image    = love.graphics.newImage('assets/environments/arrow/model_' .. heading .. '.png')
    self.imageS   = 0.8
    self.imageW   = self.image:getWidth() * self.imageS
    self.imageH   = self.image:getHeight() * self.imageS

    -- attributes
    self.heading  = heading
    self.reaction = 'cross'
end

-- ===================================
-- Draw the entity.
-- -------------
-- @return void
-- ===================================
function Arrow:draw(iso)
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
    end
end

return Arrow