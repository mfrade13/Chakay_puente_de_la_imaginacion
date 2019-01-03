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


-- forward declarations and other locals
local playBtn, credBtn

-- 'onRelease' event listener for playBtn
function onPlayBtnRelease()
	-- go to level1.lua scene
	composer.gotoScene( "level1", "fade", 500 )
	return true	-- indicates successful touch
end

function onCredBtnRelease()
	-- go to level1.lua scene
	composer.gotoScene( "src.app.views.creditos", "fade", 500 )
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( "src/assets/images/backgrounds/bosque.jpg", display.actualContentWidth, display.actualContentHeight )
--	local background = display.newRect( 0, 0, _W, _H ) 
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY

	local logo = display.newImage( sceneGroup, "src/assets/images/chakay_logo.png"  )
	logo.x=_W/2
	logo.y=_H/4


--	background:setFillColor( 0.75,0.75,0 )
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		defaultFile  ="".. btnPath .."play.png",
		overFile ="" .. btnPath .."play_over.png",
		width=196, height=128,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = _W/2
	playBtn.y = _H/2 + 150
	playBtn.isVisible = true

	credBtn = widget.newButton{
		defaultFile  ="".. btnPath .."credits.png",
		overFile ="" .. btnPath .."credits_over.png",
		width=196, height=128,
		onRelease = onCredBtnRelease	-- event listener function
	}
	credBtn.x = _W/2
	credBtn.y = _H/4*3 +50
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( logo )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( credBtn )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen

		print( db.getCurrentUser() )
		print( type( db.getCurrentUser() ) )


		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
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