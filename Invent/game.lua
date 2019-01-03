-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
local widget = require "widget" 

local score_object = require "src.app.objects.score" 
local explosions = require "src.app.objects.explotion"
local crystals = require "src.app.objects.crystals"
local blackHoles = require "src.app.objects.black_hole"
local walls = require "src.app.objects.walls"
--physics.setDrawMode( "hybrid" )
--------------------------------------------
local backgroundMusic = audio.loadStream("src/assets/sounds/music.mp3")
local backgroundMusicChannel
local crystal_sound = audio.loadSound( "src/assets/sounds/score.wav")
-- forward declarations and other locals
local _W, _H, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX
local space_ship, background, score, meteor2, layer, shield
local backGroup, midGroup, gameGroup

local replayBtn
local btnPath = "src/assets/images/botones/"

local gameplay = true
local game_timer, meteor_timer, blackHoleTimer
local control = true

local ship = graphics.newImageSheet( "src/assets/images/ships/ship.png", { width=256, height=284, numFrames=2 } )


local victory=false

--movin camara
local tPrevious = system.getTimer()
function move_layers( event )
	local tDelta = event.time - tPrevious
	tPrevious = event.time
	local yoffset = ( 0.2*tDelta )

	background.y = background.y + (yoffset*0.2)
	background2.y = background2.y + (yoffset*0.2)
	layer.y = layer.y + (yoffset*0.7)

	if background.y > (_H*7)/2 then background.y = _H/2 end
	if background2.y > (_H*7)/2 then background2.y = _H/2 end
	if layer.y>(_H*7)+50 then layer.y = 0 end
	score:increase(1)
end

function explode( e )
	explosions.createExplosion( math.random( 50, _W-50),  math.random(50,_H/2), math.random(1, 2 ), gameGroup )
end

local crys_nums = {10,50,100}


function cleanGroup( )
	for i= gameGroup.numChildren,1,-1 do
		transition.cancel( gameGroup[i] )
		if gameGroup[i].name == "black_Hole" then
			gameGroup[i]:clear()
		else
			display.remove( gameGroup[i] )
		end
		gameGroup[i]=nil
	end	
end

function stop_game( )
	gameplay=false
	control=false
	if game_timer then	timer.cancel( game_timer ) end
	if meteor_timer then timer.cancel( meteor_timer ) end
	if blackHoleTimer then  timer.cancel( blackHoleTimer ) end
	cleanGroup()
--	sceneGroup:removeEventListener( "touch", sceneGroup )
	Runtime:removeEventListener( "enterFrame", move_layers )

	if score:get_score() > 1000 then
		victory=true
	end

	replayBtn.isVisible=true
	score:scalePoints()
	audio.pause( backgroundMusicChannel )
end


local destiny=0
function restoreControl( )
	if control == false then
		control=true
		space_ship.alpha=0.2
		space_ship.xScale=space_ship.xScale* 0.2
		space_ship.yScale=space_ship.yScale* 0.2
		transition.to( space_ship, {xScale=0.25,yScale=0.25, alpha=1, time= 800} )
		space_ship.x=destiny
	end
end 

function erraseenemy(self,event)
   local collideObject = event.other
	if(event.other.name=="enemy")then

		print( self.name .. ": collision began with " .. event.other.name )
		if(self.shield == true) then
			explosions.createExplosion(event.other.x, event.other.y,2,gameGroup)
			transition.cancel( collideObject)
			physics.removeBody( collideObject )
			self.shield=false
			self:setFrame( 1 )
			display.remove(collideObject) ; collideObject = nil
		else
			explosions.createExplosion(self.x, self.y,2,gameGroup)
			transition.cancel()
			transition.cancel( meteor )
			display.remove(self); self = nil
			stop_game()				
		end
	elseif(collideObject.name == "crystal") then
		collideObject.show_score()
		transition.cancel( collideObject )
		score:increase( collideObject.get_val())
		physics.removeBody( collideObject )
		audio.play( crystal_sound )
	elseif (collideObject.name == "blackHole")then
		control=false
		transition.to( self, {x=collideObject.x,time=500, alpha=0 } )
		transition.to( self, {onComplete=restoreControl, time = 2000 } )
		self:toFront()
		collideObject:get_front()
		physics.removeBody( collideObject:get_wall() )
		destiny= collideObject:transport()
	end
	return true
end

function createBlackHoles( )
	local balck = blackHoles.spwan_blackHole( math.random( 50,_W-50 ) , 0,gameGroup, 42 )
end

function spwanMeteorits( e )
	local ranType = math.random( 1,2 )
	local meteor = display.newImageRect( gameGroup,  "src/assets/images/obstacles/circ"..ranType..".png", 70,70 )
	meteor.x = math.random( 20,_W-50 )
	meteor.y = -20
	meteor.name = "enemy"
	physics.addBody( meteor, "dynamic", {radius=30} )
	transition.to( meteor, { tag="fall",  time=5000, y= _H} )
	transition.to( meteor, {time = 5000, rotation=math.random(0,720)} )
end

function spawnCrystals( e )
	local res = math.random( 0,100 )
	local crys
	if res>0 and res<50 then
		crys = crystals.spwan_crystal( math.random( 10,_W-20 ), -20 ,10,gameGroup)
	elseif res>=50 and res <90 then
		crys = crystals.spwan_crystal( math.random( 10,_W-20 ), -20 ,50,gameGroup)
	else
		crys = crystals.spwan_crystal( math.random( 10,_W-20 ), -20 ,100,gameGroup)
	end
	crys.name = "crystal"
	nbox= { halfWidth=24, halfHeight=30, x=0, y=0, angle=45 }
	physics.addBody( crys, "dynamic" ,{box=nbox }   )

	local function clear() display.remove( crys ) end  
	transition.to( crys, {tag = "move", y=space_ship.y, time =3000, onComplete = clear} )
end

function createWalls( e )
	local dif =math.random(1,10)
	if(dif < 8) then
		local time = 9000 - ( math.log( score:get_score()) *200 )
		local rand = math.random( 1,5 )
		local wall=	walls.newWall(gameGroup,rand, time)
	else
		local balck = blackHoles.spwan_blackHole( math.random( 50,_W-50 ) , 0,gameGroup, 42 )
	end
end

function createPlayer( group )
	--	make a space_ship (off-screen), position it, and rotate slightly
	space_ship = display.newSprite( group, ship, { start=1, count=2, time=500,loopCount=1 } )
	space_ship.x, space_ship.y = _W/2, _H/4*3 +15
	space_ship.name = "space_ship"
	space_ship.shield=true
	space_ship.xScale=0.25
	space_ship.yScale = 0.25
	space_ship.rotation=180
	space_ship:setFrame( 2 )
	physics.addBody( space_ship, "static", {isSensor = true, box= { halfWidth=32, halfHeight=30, x=0, y=0, angle=0 } })
	space_ship.collision = erraseenemy	
	space_ship:addEventListener( "collision", space_ship )
end

function changeScene()
	composer.gotoScene( "level3", "fade", 500 )
	return true	-- indicates successful touch
end

function onReplayBtnRelease( )
	if (replayBtn.isVisible==true) then
		if victory==false then
			replayBtn.isVisible=false
			score:reset()
			control=true
			createPlayer(gameGroup)
			game_timer = timer.performWithDelay( 3000, spawnCrystals ,50 )
			meteor_timer = timer.performWithDelay( 7000, createWalls ,50 )
			blackHoleTimer = timer.performWithDelay( 8000, spwanMeteorits ,50 )
			shield.isVisible=true
			audio.resume( backgroundMusicChannel )
		--	sceneGroup:addEventListener( "touch", sceneGroup )
			Runtime:addEventListener( "enterFrame", move_layers )
		else 
			changeScene()
		end
	end

end


function scene:create( event )

	local sceneGroup = self.view
	backGroup = display.newGroup()
	midGroup = display.newGroup()
	gameGroup = display.newGroup()
	sceneGroup:insert( backGroup )
	sceneGroup:insert( gameGroup )
	sceneGroup:insert( midGroup )

	physics.start()
	physics.pause()

--	background = display.newRect( display.screenOriginX, display.screenOriginY, _W, _H )
	background = display.newImageRect( backGroup, "src/assets/images/backgrounds/space.jpg",_W, _H*7 )
	background.y = _H/2
	background2 = display.newImageRect( backGroup, "src/assets/images/backgrounds/space.jpg",_W, _H*7 )
	background2.y = background.contentHeight - _H/2
	background.x = _W/2
	background2.x =  _W/2

	layer = display.newImageRect( backGroup, "src/assets/images/backgrounds/rocks.png",_W+20,_H*7 )
	layer.x = _W/2+10
	layer.y = 0
	layer.anchorY=1

	replayBtn = widget.newButton{
		defaultFile  ="".. btnPath .."reload.png",
		overFile ="" .. btnPath .."reload_over.png",
		width=128, height=128,
		onRelease = onReplayBtnRelease	-- event listener function
	}
	replayBtn.x = _W/2
	replayBtn.y = _H/4*3
	replayBtn.isVisible = false

	score = score_object.new_score()
	score.x = 100
	score.y = 150

	shield = display.newImageRect( midGroup, "src/assets/images/escudo.png", 50, 60 )
	shield.x = _W- 80
	shield.y = 150

	midGroup:insert( score )
	midGroup:insert( replayBtn )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		
		physics.start()
		backgroundMusicChannel = audio.play( backgroundMusic,{loops = -1,channel = 1,} )
		victory=false
		score:reset()
		replayBtn.isVisible=false
		createPlayer(gameGroup)
		shield.isVisible=true

		function shield:touch( event )
			if self.isVisible == true then
				if(event.phase == "began")then
				
				elseif(event.phase == "ended" or event.phase == "cancelled")then

					space_ship:setFrame(2)
					space_ship.shield=true
					self.isVisible=false
				end
			end
			return true
		end

		function sceneGroup:touch(event)
			if(event.y>_H/2)then
				if(event.phase == "began")then
					--display.getCurrentStage():setFocus( t )
					print( "began" )
				elseif(event.phase == "moved")then
					if control then
						if (event.x>20 and event.x<_W-20) then
						
						space_ship.x=event.x
			--			space_ship.y = event.y
						print(" Done")
					end
					end
				elseif(event.phase == "ended" or event.phase == "cancelled")then
				--display.getCurrentStage():setFocus( nil )
				end

				return true
			end
		end

	game_timer = timer.performWithDelay( 3000, spawnCrystals ,50 )
	meteor_timer = timer.performWithDelay( 7000, createWalls ,50 )
	blackHoleTimer = timer.performWithDelay( 8000, spwanMeteorits ,50 )
	
	sceneGroup:addEventListener( "touch", sceneGroup )
	shield:addEventListener( "touch", shield )
	Runtime:addEventListener( "enterFrame", move_layers )
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
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene