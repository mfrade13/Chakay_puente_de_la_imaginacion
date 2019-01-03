module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight

local physics = require "physics"

local path = "src/assets/images/crystals/"

function spwan_crystal( posx,posy,type,group )
	local back,glow,front,num
	local crystal = display.newGroup()
	back = display.newImageRect( crystal, path..""..type.."/atras.png", 48, 60 )
	glow = display.newImageRect( crystal, path..""..type.."/glow.png", 48, 60 )
	front = display.newImageRect( crystal, path..""..type.."/front.png", 48, 60 )
	num = display.newImageRect(crystal, path..""..type.."/"..type..".png",60,75 )
	num.isVisible =false

	crystal.name = "crystal"
	crystal.val = type
	crystal.x=posx
	crystal.y=posy

	function clear_crystal( ... )
		num.isVisible=false
		display.remove( crystal )
	end

	function crystal:show_score( )
		timer.cancel( crystal.timer)
		glow.isVisible=false
		back.isVisible=false
		front.isVisible=false
		num.isVisible=true
		crystal.name="deleted"
		transition.to( num, {x=-100,y=-180, alpha=0.2,time= 1000,OnComplete=clear_crystal } )
	end

	function restore()
		glow.alpha=1
	end

	function blink(  )
		glow.alpha=1
		transition.to( glow, {alpha=0.5, time=1000,OnComplete = restore} )
	end
	crystal.timer =	timer.performWithDelay( 500, blink,-1 )

	function crystal:get_val(  )
		return crystal.val
	end

	group:insert( crystal )
	return crystal
end


