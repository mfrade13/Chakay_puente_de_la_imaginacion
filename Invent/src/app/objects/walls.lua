module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight

local physics = require "physics"

local path = "src/assets/images/obstacles/"

function newWall( group,typeD,period )
	local wall, wall2


	if typeD == 1 then
		wall = display.newImageRect( group, path.."triangular.png", 199,167  )
		wall.x = _W-90
		wall.y= -100
		wall.name = "enemy"
		local Shape = { -100,-80, 40,-20, 98,80, 98,-80 }
		physics.addBody( wall, "dynamic", {density=3.0, shape=Shape } )

		function clear( )
			physics.removeBody( wall )
			display.remove( wall )
		end

		transition.to( wall, {y=_H*2, time = period*1.5, onComplete=clear} )
	
	elseif  typeD==2 then
		wall = display.newImageRect( group, path.."der.png", 120,295  )
		wall.x = _W-60
		wall.y= -100
		wall.name = "enemy"

		physics.addBody( wall, "dynamic", {density=3.0, box= { halfWidth=60, halfHeight=143, x=0, y=0 }} )


		wall2 = display.newImageRect( group, path.."der.png", 120,295  )
		wall2.x = 60
		wall2.y= -100
		wall2.rotation=180	
		wall2.name = "enemy"


		physics.addBody( wall2, "dynamic", {density=3.0, box= { halfWidth=60, halfHeight=143, x=0, y=0 }} )


		function clear( )
			physics.removeBody( wall )
			display.remove( wall )
		end

		function clear2( )
			physics.removeBody( wall2 )
			display.remove( wall2 )
		end

		transition.to( wall, {y=_H*2, time = period*1.5, onComplete=clear} )
		transition.to( wall2, {y=_H*2, time = period*1.5, onComplete=clear2} )
	
	elseif typeD ==3 then 
		wall = display.newImageRect( group, path.."cuadrado.png", 168,180  )
		wall.x = _W/2
		wall.y= -100
		wall.name = "enemy"
		physics.addBody( wall, "dynamic", {density=3.0, box= { halfWidth=84, halfHeight=90, x=0, y=0 } } )
		function clear( )
			physics.removeBody( wall )
			display.remove( wall )
		end

		transition.to( wall, {y=_H*2, time = period*1.5, onComplete=clear} )

	else
		wall = display.newImageRect( group, path.."digder.png", 150,360  )
		wall.x = _W-60
		wall.y= -100
		wall.name = "enemy"


		local Shape = { -75,-175, 70,160, 70,-175 }
		physics.addBody( wall, "dynamic", {density=3.0, shape=Shape } )

		wall2 = display.newImageRect( group, path.."digizq.png", 150,380  )
		wall2.x = 75
		wall2.y= -100
		wall2.name = "enemy"

		local Shape2 = { -75,-190, -75,180, 75,180 }

		physics.addBody( wall2, "dynamic", {density=3.0, shape=Shape2 } )


		function clear( )
			physics.removeBody( wall )
			display.remove( wall )
		end

		function clear2( )
			physics.removeBody( wall2 )
			display.remove( wall2 )
		end

		transition.to( wall, {y=_H*2, time = period*1.5, onComplete=clear} )
		transition.to( wall2, {y=_H*2, time = period*1.5, onComplete=clear2} )
	

	end

end
