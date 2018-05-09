--=======================================
-- filename:    settings/controls.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Control/input settings.
--=======================================

Input = require 'tools.input.input'
Event = require 'tools.event'

Input:new()  -- Input handler
Event:new()  -- Event dispatcher

-- ==============================
-- Keyboard events (Game Screen)
-- ==============================

Input:press('escape', function() love.event.quit() end)
Input:press('space',  function() Event:dispatch('player.fire') end)
Input:press('lctrl', function() Event:dispatch('player.enableLock') end)
Input:press('lshift', function() Event:dispatch('player.enableRun') end)

Input:release('w',      function() Event:dispatch('player.rest', 2) end)
Input:release('s',      function() Event:dispatch('player.rest', 2) end)
Input:release('a',      function() Event:dispatch('player.rest', 1) end)
Input:release('d',      function() Event:dispatch('player.rest', 1) end)
Input:release('lctrl',  function() Event:dispatch('player.disableLock') end)
Input:release('lshift', function() Event:dispatch('player.disableRun') end)

Input:down('w', function() Event:dispatch('player.move', 2, -1) end, 0.02)
Input:down('s', function() Event:dispatch('player.move', 2, 1) end, 0.02)
Input:down('a', function() Event:dispatch('player.move', 1, -1) end, 0.02)
Input:down('d', function() Event:dispatch('player.move', 1, 1) end, 0.02)

-- ==============================
-- Gamepad events (Game Screen)
-- ==============================

Input:press('btnB',     function() Event:dispatch('player.fire') end)
Input:press('btnLB',    function() Event:dispatch('player.enableLock') end)
Input:press('btnRB',    function() Event:dispatch('player.enableRun') end)

Input:release('btnUp',    function() Event:dispatch('player.rest', 2) end)
Input:release('btnDown',  function() Event:dispatch('player.rest', 2) end)
Input:release('btnLeft',  function() Event:dispatch('player.rest', 1) end)
Input:release('btnRight', function() Event:dispatch('player.rest', 1) end)
Input:release('btnLB',    function() Event:dispatch('player.disableLock') end)
Input:release('btnRB',    function() Event:dispatch('player.disableRun') end)

Input:down('btnUp',    function() Event:dispatch('player.move', 2, -1) end, 0.02)
Input:down('btnDown',  function() Event:dispatch('player.move', 2, 1)  end, 0.02)
Input:down('btnLeft',  function() Event:dispatch('player.move', 1, -1) end, 0.02)
Input:down('btnRight', function() Event:dispatch('player.move', 1, 1)  end, 0.02)