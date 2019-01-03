module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight

local path = "src/assets/images/obstacles/"

local explode1 = graphics.newImageSheet( path .. "explosion.png", { width=128, height=128, numFrames=6 } )
local explode2 = graphics.newImageSheet( path .."explosion_roja.png", { width=128, height=128, numFrames=6 } )
local audio1 = audio.loadSound( "src/assets/sounds/explosion.mp3")

function createExplosion( posx,posy,type, group )
	local  effect 
	if(type ==1 )then
		effect = display.newSprite( group, explode1, { start=1, count=6, time=500,loopCount=1 } )
	else 
		effect = display.newSprite( group, explode2, { start=1, count=6, time=500,loopCount=1 } )
	end
	effect.x=posx; effect.y=posy
	effect.xScale=0.3; effect.yScale=0.3
	effect:play()
	audio.play( audio1 )
	local function clearBomb()
		effect:removeSelf()
		effect=nil
	end	
		transition.to(effect,{onComplete=clearBomb,time=650})
end
	