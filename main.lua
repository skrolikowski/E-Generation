--=======================================
-- filename:    main.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Bootstrapper.
--=======================================

require 'settings.includes'
require 'settings.constants'
require 'settings.controls'

love.graphics.setLineJoin('miter')
love.graphics.setLineStyle('smooth')

random = love.math.random
max    = math.max
min    = math.min

IMAGE['background'][1]:setWrap('repeat', 'repeat')

function love.load()
    controller = Controller()
    controller:loadRoom(1, '001')
end

function love.update(dt)
    Input:update(dt)

    controller:update(dt)
end

function love.draw()
    love.graphics.setColor(UI['color']['white'])
    love.graphics.draw(IMAGE['background'][2], QUAD['background'])

    controller:draw()
end
