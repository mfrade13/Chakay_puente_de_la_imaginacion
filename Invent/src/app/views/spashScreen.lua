-----------------------------------------------------------------------------------------
--
-- composer.lua
--
-----------------------------------------------------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight

local composer = require( "composer" )
local scene = composer.newScene()

local background 

function load ()
	transition.to( background,{ onComplete=gotoMenu, time=2000 } )
end

function gotoMenu(  )
	local options =
	{
		effect = "zoomOutInFade", --"zoomOutInFade"
		time = 500,
	}
	composer.gotoScene( "menu" ,options)
end


function scene:create( event )
	local sceneGroup = self.view

	background = display.newRect( sceneGroup, _W/2, _H/2, _W, _H )
	local logo = display.newImage( sceneGroup, "src/assets/images/focuart.png"  )
	logo.x=_W/2
	logo.y=_H/2


	
--	logo.xScale=0.5
--	logo.yScale=0.5
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		load()
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
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
