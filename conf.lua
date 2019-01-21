package.path = "../?.lua;" .. package.path

function love.conf(t)
    io.stdout:setvbuf('no')

    t.identity = 'project-dgen'
    t.version  = '11.1'
    t.console  = false

    t.window.title      = 'DGen'
    -- t.window.icon       = 'assets/ui/cursor_pointer3D.png'
    t.window.x          = 5
    t.window.y          = 25
    t.window.width      = 1000
    t.window.height     = 1000
    t.window.fullscreen = false
    t.window.highdpi    = true
    t.window.vsync      = true

    t.modules.physics = false
    t.modules.touch   = false
    t.modules.video   = false
end
