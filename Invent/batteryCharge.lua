-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local db = require "db"

-- include Corona's "widget" library
local widget = require "widget"
--------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight

local btnPath = "src/assets/images/botones/"
local maquinaPath = "src/assets/maquina/"
local audioPath = "src/assets/sounds/"
----audios streams
local platilloSound = audio.loadStream(""..audioPath.."platillo.ogg")
local trompetaSound1 = audio.loadStream(""..audioPath.."trompeta1.mp3")
local trompetaSound2 = audio.loadStream(""..audioPath.."trompeta2.mp3")
local trompetaSound3 = audio.loadStream(""..audioPath.."trompeta3.mp3")
local trompetaSound4 = audio.loadStream(""..audioPath.."trompeta4.mp3")
local trompetasSounds = {trompetaSound1, trompetaSound4, trompetaSound3} 
local cajaSound1 = audio.loadStream(""..audioPath.."caja.mp3")
local acordeonSound1 = audio.loadStream(""..audioPath.."acordeon1.mp3")
local acordeonSound2 = audio.loadStream(""..audioPath.."acordeon2.mp3")
local acordeonSounds = {acordeonSound1, acordeonSound2}
local maracasSound = audio.loadStream(""..audioPath.."maracas.ogg")
local tamborSound = audio.loadStream(""..audioPath.."tambor1.mp3")



-- forward declarations and other locals
local playBtn, credBtn

-- 'onRelease' event listener for playBtn
function onPlayBtnRelease()
	-- go to level1.lua scene
	composer.gotoScene( "level2", "fade", 500 )
	return true	-- indicates successful touch
end

function onCredBtnRelease()
	-- go to level1.lua scene
	composer.gotoScene( "src.app.views.creditos", "fade", 500 )
	return true	-- indicates successful touch
end

local background
local acordeon1, acordeon2, caja1, caja2, maracas1, maracas2, platillo1, platillo2
local tambor1, tambor2, trompeta1, trompeta2, bateriaB, bateriaM, bateriaF
local baterXOrigin
local tam = false
local mar = false
local pla = false
local caj = false
local tro = false
local aco = false

function increase_battery( )
	local currentsize = bateriaM.xScale
	
	local increase = currentsize/50

	bateriaM.xScale = currentsize+increase
	print( "xScale = " ..bateriaM.xScale )
	print( "width = " ..bateriaM.width )
	print( "x = " ..bateriaM.x )
	bateriaM.x = bateriaM.x -1

end


function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	background = display.newImage( "src/assets/maquina/fondo.jpg", _W/2, _H/2 )
--	local background = display.newRect( 0, 0, _W, _H ) 
--	background:setFillColor( 0.75,0.75,0 )
	
	acordeon1 = display.newImage( ""..maquinaPath.."acordeon1.png",_W/2,_H/2 )
	acordeon2 = display.newImage( ""..maquinaPath.."acordeon2.png",_W/2,_H/2 )
	acordeon2.isVisible=false
	caja1 = display.newImage( ""..maquinaPath.."caja1.png",_W/2,_H/2 )
	caja2 = display.newImage( ""..maquinaPath.."caja2.png",_W/2,_H/2 )
	caja2.isVisible=false
	maracas1 = display.newImage( ""..maquinaPath.."maracas1.png",_W/2,_H/2 )
	maracas2 = display.newImage( ""..maquinaPath.."maracas2.png",_W/2,_H/2 )
	maracas2.isVisible=false
	platillo1 = display.newImage( ""..maquinaPath.."platillo1.png",_W/2,_H/2)
	platillo2 = display.newImage( ""..maquinaPath.."platillo2.png",_W/2,_H/2)
	platillo2.isVisible=false
	tambor1 = display.newImage( ""..maquinaPath.."tambor1.png",_W/2,_H/2 )
	tambor2 = display.newImage( ""..maquinaPath.."tambor2.png",_W/2,_H/2 )
	tambor2.isVisible=false
	trompeta1 = display.newImage( ""..maquinaPath.."trompeta1.png",_W/2,_H/2 )
	trompeta2 = display.newImage( ""..maquinaPath.."trompeta2.png",_W/2,_H/2 )
	trompeta2.isVisible=false
	bateriaB = display.newImage( ""..maquinaPath.."bateriaB.png",_W/2,_H/2 )

	bateriaM = display.newImage( ""..maquinaPath.."bateriaM.png",_W/2,_H/2 )
	-- bateriaM.xScale = 0.1
	bateriaM.anchorX = 0
	bateriaM.x = bateriaM.x -220
	bateriaF = display.newImage( ""..maquinaPath.."bateriaF.png",_W/2,_H/2 )

	baterXOrigin=bateriaM.x
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		defaultFile  ="".. btnPath .."button.png",
		overFile ="" .. btnPath .."button-over.png",
		width=128, height=128,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = _W/4*3
	playBtn.y = _H/2 +50
	playBtn.isVisible = false

	-- credBtn = widget.newButton{
	-- 	defaultFile  ="".. btnPath .."button.png",
	-- 	overFile ="" .. btnPath .."button-over.png",
	-- 	width=128, height=128,
	-- 	onRelease = onCredBtnRelease	-- event listener function
	-- }
	-- credBtn.x = _W/4*3
	-- credBtn.y = _H/2 +150
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( acordeon1 )
	sceneGroup:insert( caja1 )
	sceneGroup:insert( maracas1 )
	sceneGroup:insert( platillo1 )
	sceneGroup:insert( tambor1 )
	sceneGroup:insert( trompeta1 )

	sceneGroup:insert( acordeon2 )
	sceneGroup:insert( caja2 )
	sceneGroup:insert( maracas2 )
	sceneGroup:insert( platillo2 )
	sceneGroup:insert( tambor2 )
	sceneGroup:insert( trompeta2 )


	sceneGroup:insert( bateriaB )
	sceneGroup:insert( bateriaM )
	sceneGroup:insert( bateriaF )



	sceneGroup:insert( playBtn )
	--sceneGroup:insert( credBtn )
end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	bateriaM.xScale = 0.1
	bateriaM.anchorX = 0
	bateriaM.x = baterXOrigin
	elseif phase == "did" then
		-- Called when the scene is now on screen

	function background:touch(event)
		if event.phase == "began" then
			if bateriaM.xScale <= 0.93 then
				if event.y > 630 and event.y <800 and event.x > 305 and event.x < 500 then
					tambor2.isVisible=true
					audio.play( tamborSound)
					tam = true	
				end
				if event.y > 400 and event.y <520 and event.x > 330 and event.x < 490 then
					maracas2.isVisible=true
					audio.play( maracasSound  )
					mar = true
				end
				if event.y > 535 and event.y <660 and event.x > 96 and event.x < 300 then
					platillo2.isVisible=true
					pla = true
					platillo1.isVisible=false
					audio.play( platilloSound )
				end

				if event.y > 460 and event.y <640 and event.x > 515 and event.x < 740 then
					trompeta2.isVisible=true
					trompeta1.isVisible=false
					local trompNum = math.random( 1, 3 )
					audio.play( trompetasSounds[trompNum] )
					tro = true
				end
				if event.y > 770 and event.y 		<940 and event.x > 110 and event.x < 250 then
					caja2.isVisible=true
					caja1.isVisible=false
					audio.play(cajaSound1)
					caj = true
				end
				if event.y > 770 and event.y <930 and event.x > 570 and event.x < 725 then
					acordeon2.isVisible=true
					acordeon1.isVisible=false
					local acordNum = math.random( 1, 2 )
					audio.play( acordeonSounds[acordNum])
					aco = true
				end
			end
		elseif event.phase == "moved" then

		elseif event.phase == "ended" or event.phase == "cancelled" then
			if bateriaM.xScale < 0.93 then
				if tam then
					tambor2.isVisible=false
					increase_battery()
					tam = false
				end
				if mar then
					maracas2.isVisible=false
					increase_battery()
					mar = false
				end
				if pla then
					platillo2.isVisible=false
					platillo1.isVisible=true
					increase_battery()
					pla = false
				end
				if tro then
					trompeta2.isVisible=false
					trompeta1.isVisible=true
					increase_battery()
					tro = false
				end

				if aco then
					acordeon2.isVisible=false
					acordeon1.isVisible=true
					increase_battery()
					aco = false
				end

				if caj then
					caja2.isVisible=false
					caja1.isVisible=true
					increase_battery()
					caj = false
				end

			else
				onPlayBtnRelease()

			end

		end
	end	
	

	-- tambor1:addEventListener( "touch", tambor1 )
	-- maracas1:addEventListener( "touch", maracas1 )
	-- platillo1:addEventListener( "touch", platillo1 )
	-- maracas1:addEventListener( "touch", maracas1 )
	background:addEventListener( "touch", background )

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)

	background:removeEventListener( "touch", background )

	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene