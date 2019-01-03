module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight

local physics = require "physics"

local path = "src/assets/images/blackhole"

local sizeFactor = 90

function spwan_blackHole( posx,posy,group,frontGroup )
	local back,agujero,front,exit, bridge
	local blackHole = display.newGroup()
	back = display.newImageRect( blackHole, path.."/atras.png", sizeFactor, sizeFactor )
    back.x=posx;back.y=posy
	agujero = display.newImageRect( blackHole, path.."/agujero.png", sizeFactor, sizeFactor )
	agujero.x=posx;agujero.y=posy; agujero.name="blackHole"
	front = display.newImageRect( blackHole, path.."/front.png", sizeFactor, sizeFactor )
	front.x = posx; front.y =posy

	exit = display.newImageRect(blackHole, path.."/salida.png",sizeFactor,sizeFactor )
	exit.x = math.random( 50,_W-50 )  ; exit.y = posy-300
	exit.alpha = 0.8

	bridge = display.newImageRect( blackHole, path.."/puente.png", _W, _W/2 )	
	bridge.x = _W/2
	bridge.y = posy-150
	bridge.name = "enemy"

	blackHole.name = "black_Hole"

	physics.addBody( agujero, "dynamic", {box= { halfWidth=35, halfHeight=35, x=0, y=0}} )
	physics.addBody( bridge, "dynamic" , {density=3.0, box ={ halfWidth=_W/2,halfHeight=_W/5,x=0,y=0 }} )


	function clear_blackHole( )
	 	 transition.cancel( exit )
	 	 transition.cancel( back )

		 timer.cancel( blackHole.timer )
	 	 transition.cancel( exit )
	 	 transition.cancel( back )

	 	 display.remove( blackHole )
	end

	function agujero:transport(  )
		print( "[...]" .. exit.x )
		return exit.x
	end

	function blackHole:clear(  )
		clear_blackHole()
	end

	function agujero:get_front(  )
		front:toFront( )
	end

	function agujero:get_wall(  )
		bridge.name = "nothing"
		return bridge
	end

	function rotate( e )
		back.rotation=0
		transition.to( back, {rotation=360, time=1500,} )
		transition.to( exit, {rotation=exit.rotation+40, time=1500} )
	end
	blackHole.timer = timer.performWithDelay( 1500, rotate,-1 )




	local offset = 700

	transition.to( agujero, {y= _H + offset, time= 7000 } )
	transition.to( exit, {y= _H +  offset-300, time= 7000, onComplete=clear_blackHole } )
	transition.to( back, {y= _H + offset , time= 7000 } )
	transition.to( front, {y= _H + offset, time= 7000 } )
	transition.to( bridge, {y= _H + offset-150, time= 7000 } )


	group:insert( blackHole )
	return blackHole
end


