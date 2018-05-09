--=======================================
-- filename:    settings/constants.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: Game constants.
--=======================================

GAME = {
    debug = false,
    tick  = 1
}

WORLD = {
    width  = love.graphics.getWidth(),
    height = love.graphics.getHeight()
}

GRID = {
    xOffset = 0,
    yOffset = 0,
    rows    = 16,
    cols    = 16,
    cell    = {
        size    = 32,
        depth   = 10,
        padding = 0
    },
    colors = 1
}

IMAGE = {
    background = {
        love.graphics.newImage('assets/backgrounds/blue.png'),
        love.graphics.newImage('assets/backgrounds/black.png'),
    },
    unit = {
        player = {
            love.graphics.newImage('assets/units/player/stand.png'),
        },
    },
    enemy = {
        turret = {
            love.graphics.newImage('assets/enemies/turret/inactive.png'),
            love.graphics.newImage('assets/enemies/turret/active.png'),
        },
    },
}

QUAD = {
    background = love.graphics.newQuad(0, 0, WORLD['width'], WORLD['height'], IMAGE['background'][1]:getDimensions()),
    unit = {
        player = {
            love.graphics.newQuad(0,   0,   42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(42,  0,   42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(84,  0,   42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(126, 0,   42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(168, 0,   42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(210, 0,   42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(0,   85,  42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(42,  85,  42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(84,  85,  42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(126, 85,  42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(168, 85,  42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(210, 85,  42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(0,   170, 42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(42,  170, 42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(84,  170, 42, 85, IMAGE['unit']['player'][1]:getDimensions()),
            love.graphics.newQuad(126, 170, 42, 85, IMAGE['unit']['player'][1]:getDimensions()),
        },
    },
    enemy = {
        turret = {
            love.graphics.newQuad(0,   0,   68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(68,  0,   68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(136, 0,   68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(204, 0,   68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(272, 0,   68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(340, 0,   68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(408, 0,   68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(0,   85,  68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(68,  85,  68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(136, 85,  68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(204, 85,  68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(272, 85,  68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(340, 85,  68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(408, 85,  68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(0,   170, 68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
            love.graphics.newQuad(68,  170, 68, 85, IMAGE['enemy']['turret'][2]:getDimensions()),
        },
    },
}

AUDIO = {
    unit = {
        love.audio.newSource('assets/audio/footstep05.ogg'),
    },
    particle = {
        love.audio.newSource('assets/audio/laser2.ogg'),
        love.audio.newSource('assets/audio/laser4.ogg'),
    }
}

ANGLES = {
    sixteenths = {
        0,
        0.393,
        0.785,
        1.178,
        1.571,
        1.963,
        2.356,
        2.749,
        3.142,
        3.534,
        3.927,
        4.320,
        4.712,
        5.105,
        5.498,
        5.890
    },
    headings = {
        N = 3 * math.pi / 2,
        E = 0,
        W = math.pi,
        S = math.pi / 2
    }
}

UI = {
    color = {
        white  = {255,255,255},
        scheme = {
            {
                {25,25,25,255},     -- top fill color
                {17,45,78,255},     -- left fill color
                {0,0,0,255},        -- right fill color
                {245,245,245,255},  -- top line color
            }
        },
        door = {
            O = {
                {249,126,32,255},
                {249,126,32,255},
                {249,126,32,255},
            },
            R = {
                {151,0,37,255},
                {151,0,37,255},
                {151,0,37,255},
            },
            Y = {
                {255,209,49,255},
                {255,209,49,255},
                {255,209,49,255},
            },
            B = {
                {15,50,116,255},
                {15,50,116,255},
                {15,50,116,255},
            },
            P = {
                {184,5,91,255},
                {184,5,91,255},
                {184,5,91,255},
            },
            H = {
                {25,25,25,255},
                {17,45,78,255},
                {0,0,0,255},
            },
        },
    },
}

-- Environments
-- 'I001' => entering from
-- 'O001' => exiting to
-- 'XXXX' => invisible cell
-- 'F000' => floor (2 => color scheme, 3-4 => n/a)
-- '1000' => wall (1 => depth, 2 => heading, 3 => switch code, 4 => accessory)
-- 'A1S0' => arrow sign (2 => depth, 3 => heading, 4 => n/a)
-- 'C000' => crate
-- 'T000' => teleporter (2-4 => room code)
-- 'E00S' => elevator (2 => floor, 3 => spawn, 4 => heading)
-- 'V1S0' => vent (2 => depth, 3 => heading, 4 => n/a)
-- 'D100' => door (2 => key/code, 3 => color, 4 => open)
-- 'S100' => floor switch (2 => code, 3-4 => n/a)

-- Decorations
-- '_DCS' => desk (3 => accessory, 4 => heading)
-- '_BS0' => Bookshelf (3 => accessory, 4 => n/a)
-- '_FS0' => fridge (3 => heading, 4 => n/a)
-- '_L00' => floor lamp (3-4 => n/a)
-- '_CS0' => chair (3 => heading, 4 => n/a)
-- '_P00' => plant (3-4 => n/a)
-- '_WS0' => watercooler (3 => heading, 4 => n/a)
-- '_GS0' => garbage can (3 => heading, 4 => n/a)
-- '_AS0' => cabinet (3 => heading, 4 => n/a)
-- '_OSF' => couch (3 => heading, 4 => corner)
-- '_VS0' => oven (3 => heading, 4 => n/a)
-- '_US0' => counter (3 => heading, 4 => version)
-- '_TS0' => table (3 => heading, 4 => accessory)
-- '_ES0' => toilet (3 => heading, 4 => n/a)

-- Enemies
-- '-CN0' => chaser (3 => heading, 4 => n/a)
-- '-SN0' => soldier (3 => heading, 4 => n/a)
-- '-T1T' => turret (3 => code, 4 => active)
-- '-Z30' => zapper (3 => delay, 4 => delay)
-- '-LS1' => launcher (3 => heading, 4 => code)
-- '-OS0' => oracle (3 => heading, 4 => n/a)

-- Units
-- '+PN0' => player (3 => heading, 4 => n/a)
-- '+CN1' => civilian (3 => heading, 4 => sitting)

ROOMS = {
    {
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000'},
        {'5000','_P00','_WS0','_BS0','_BS0','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000'},
        {'5000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000'},
        {'5000','_BE0','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000'},
        {'5000','_OE0','F000','-O60','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000'},
        {'5000','_OE0','F000','F000','F000','F000','_CS0','_CS0','_CS0','_CS0','_CS0','_CS0','_CS0','F000','F000','1000'},
        {'5000','_P00','F000','F000','F000','_CW0','_TWE','_TS0','_TSP','_TSC','_TSP','_TS0','_TEE','_CE0','F000','1000'},
        {'5000','3000','3000','3000','F000','F000','_CN0','F000','_CN0','_CN0','_CN0','_CN0','_CN0','F000','F000','1000'},
        {'5000','_USX','_USC','_USC','F000','F000','F000','_CN0','F000','F000','F000','F000','F000','F000','F000','1000'},
        {'5000','_VE0','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000'},
        {'5000','_UET','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000'},
        {'5000','_FE0','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','1000','1000','1000','1000'},
        {'5000','1000','1000','1000','1000','1000','1000','1000','1000','I000','F000','1000','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','1000','1000','1000','1000','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
    },
    {
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','5000','O002','O002','1000'},
        {'5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','I002','F000','1000'},
        {'O003','I003','F000','-CE0','F000','D2RF','F000','F000','F000','V3S0','F000','F000','F000','F000','F000','1000'},
        {'O003','F000','F000','F000','F000','D2RF','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000'},
        {'1000','1000','1000','1000','1000','1000','1000','1000','1000','F000','F000','1000','F000','F000','1000','1000'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','1000','_DBE','_DCS','F000','F000','F000','1000','D1OF','D1OF','_P00','1000'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','1000','_DLE','_CS0','F000','F000','F000','1E1T','F000','F000','F000','1000'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','1000','F000','F000','F000','-Z23','F000','F000','F000','F000','F000','1000'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','1000','F000','F000','F000','F000','F000','1000','F000','F000','F000','1000'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','1000','F000','F000','F000','F000','F000','1000','F000','F000','_CS0','1000'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','1000','F000','F000','F000','F000','F000','1000','_L00','_DBS','_D00','1000'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','1000','1000','1000','1000','F000','F000','1000','1000','1000','1000','1000'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','1000','F000','F000','1000','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','1000','I000','F000','1000','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','1000','1000','1000','1000','XXXX','XXXX','XXXX','XXXX'},
    },
    {
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','XXXX'},
        {'XXXX','1000','_DLS','_DCS','_P00','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','_CN0','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','-T0T','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','F000','F000','F000','1000','1000','1000','1000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','1000','F000','F000','1000','_D00','_DCS','_P00','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','1000','F000','F000','1000','_CE0','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','1000','F000','F000','1000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','1000','F000','F000','1000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','I001','F000','1000','1000','1000','1000','1000','1000','1000','1000','1000','1000','1000','XXXX'},
        {'XXXX','1000','O001','O001','1000','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
    },
    {
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000','5000'},
        {'XXXX','1000','_WS0','_GS0','F000','F000','1000','_D00','_D00','_GS0','1000','_DCS','_D00','F000','I001','O001'},
        {'XXXX','1000','F000','F000','F000','F000','1000','_CE0','F000','F000','1000','_CN0','F000','F000','F000','O001'},
        {'XXXX','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','1000'},
        {'XXXX','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','1000','1000','-SN0','F000','F000','F000','F000','1000','1000','1000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','F000','F000','F000','F000','F000','1000','F000','_P00','F000','F000','1000','XXXX'},
        {'XXXX','1000','_DLE','F000','F000','F000','F000','F000','F000','1000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','_D00','F000','F000','F000','F000','F000','F000','1000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','1000','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','_DBE','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','_D00','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','F000','1000','XXXX'},
        {'XXXX','1000','1000','1000','1000','1000','1000','1000','1000','1000','1000','1000','1000','1000','1000','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
    },
    {
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','5000','500T','500T','500T','500T','500T','5000','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','5000','5000','5000','_US0','_USS','_USS','_USS','_US0','1000','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','_EE0','F000','1000','F000','F000','F000','F000','F000','0000','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','F000','F000','D0BT','F000','F000','F000','F000','F000','0000','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','1000','1000','1000','F000','F000','F000','F000','F000','0000','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','_EE0','F000','1000','F000','F000','F000','F000','_P00','0000','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','F000','F000','D0BT','F000','F000','F000','F000','_L00','0000','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','1000','1000','1000','F000','F000','F000','F000','0000','0000','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','_EE0','F000','1000','F000','F000','F000','F000','0000','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','F000','F000','D0BT','F000','F000','F000','F000','0000','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','5000','1000','1000','1000','1000','1000','F000','F000','0000','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','1000','F000','F000','0000','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','1000','I000','F000','0000','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','1000','F000','F000','0000','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
        {'XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','1000','0000','0000','0000','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX'},
    },
}