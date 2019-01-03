-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local scenePath = "src/assets/images/escenas/"
-- include Corona's "physics" library
local physics = require "physics"
local background,bg1,bg2,bg3
--------------------------------------------

-- forward declarations and other locals
local _W, _H, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

local touchAble= false
local moment =1

function alloudTouch(  )
	touchAble=true
end

function blockTouch()
	touchAble=false
	transition.to( background, {onComplete=alloudTouch, time=1500} )
end

function changeScene()
	composer.gotoScene( "src.app.views.creditos", "fade", 500 )
	return true	-- indicates successful touch
end

function storyHandler(  )
	if touchAble then
		if moment ==1 then
			moment=3
			bg2.isVisible=true
			blockTouch()
		elseif moment == 3 then
			moment=4
			bg3.isVisible=true
			blockTouch()
		elseif moment == 4 then
			moment=1
			blockTouch()
			changeScene()
		end	
	end
	return true
end

function scene:create( event )

	local sceneGroup = self.view

	background = display.newImageRect( "src/assets/images/backgrounds/escuela.jpg", _W, _H )
	background.anchorX = 0 
	background.anchorY = 0
	
	bg2 = display.newImageRect( scenePath.."contest.jpg", _W, _H )
	bg2.anchorX = 0 
	bg2.anchorY = 0
	
	bg3 = display.newImageRect( scenePath.."18.jpg", _W, _H )
	bg3.anchorX = 0 
	bg3.anchorY = 0

	sceneGroup:insert( background )
	sceneGroup:insert( bg2 )
	sceneGroup:insert( bg3 )

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen

		bg2.isVisible = false
		bg3.isVisible = false


	elseif phase == "did" then
		touchAble=true
		Runtime:addEventListener( "touch", storyHandler )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		bg2.isVisible = false
		bg3.isVisible = false

		Runtime:removeEventListener( "touch", storyHandler )
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
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene