--=======================================
-- filename:    settings/includes.lua
-- author:      Shane Krolikowski
-- created:     Apr, 2018
-- description: File includes.
--=======================================

-- Game libraries
Inspect = require 'libs.inspect.inspect'
Timer   = require 'libs.hump.timer'
Bump    = require 'libs.bump.bump'

-- Game tools
Vec2       = require 'tools.vec2'
Soundtrack = require 'tools.audio.soundtrack'
UMath      = require 'tools.utils.math'
UColor     = require 'tools.utils.color'
UTable     = require 'tools.utils.table'
UString    = require 'tools.utils.string'
SManager   = require 'tools.ai.steermanager'
FSM        = require 'tools.ai.fsm'
Tracker    = require 'tools.ai.tracker'
Influence  = require 'tools.algorithms.influence'
PathFinder = require 'tools.algorithms.pathfinding'
Animator   = require 'tools.graphics.animator'

-- Game map
Grid       = require 'map.grid'
Cell       = require 'map.cell'

-- Containers
Array     = require 'tools.containers.array'
Path      = require 'tools.containers.path'

-- Game entities
Controller  = require 'controller'
Spawner     = require 'entities.spawner'

-- Units
Player      = require 'entities.units.player'

-- Particles
Laser       = require 'entities.particles.laser'
Photon      = require 'entities.particles.photon'

-- Decorations
Books       = require 'entities.decorations.books'
Bookshelf   = require 'entities.decorations.bookshelf'
Cabinet     = require 'entities.decorations.cabinet'
Chair       = require 'entities.decorations.chair'
Computer    = require 'entities.decorations.computer'
Couch       = require 'entities.decorations.couch'
Counter     = require 'entities.decorations.counter'
Desk        = require 'entities.decorations.desk'
DLamp       = require 'entities.decorations.d_lamp'
FLamp       = require 'entities.decorations.f_lamp'
Fridge      = require 'entities.decorations.fridge'
Garbage     = require 'entities.decorations.garbage'
Oven        = require 'entities.decorations.oven'
Plant       = require 'entities.decorations.plant'
Table       = require 'entities.decorations.table'
Toilet      = require 'entities.decorations.toilet'
Watercooler = require 'entities.decorations.watercooler'

-- Environment
Arrow       = require 'entities.environments.arrow'
Crate       = require 'entities.environments.crate'
Door        = require 'entities.environments.door'
Entrance    = require 'entities.environments.entrance'
Elevator    = require 'entities.environments.elevator'
Exit        = require 'entities.environments.exit'
FSwitch     = require 'entities.environments.f_switch'
Teleporter  = require 'entities.environments.teleporter'
Wall        = require 'entities.environments.wall'
Vent        = require 'entities.environments.vent'

-- Enemies
Chaser      = require 'entities.enemies.chaser'
Launcher    = require 'entities.enemies.launcher'
Oracle      = require 'entities.enemies.oracle'
Soldier     = require 'entities.enemies.soldier'
Turret      = require 'entities.enemies.turret'
Zapper      = require 'entities.enemies.zapper'