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
local background,bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9
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
	composer.gotoScene( "game", "fade", 500 )
	return true	-- indicates successful touch
end

function storyHandler(  )
	if touchAble then
		if moment ==1 then
			moment=2
			bg1.isVisible=true
			blockTouch()
		elseif moment == 2 then
			moment=3
			bg2.isVisible=true
			blockTouch()
		elseif moment == 3 then
			moment=4
			bg3.isVisible=true
			blockTouch()
		elseif moment == 4 then
			moment=5
			bg4.isVisible=true
			blockTouch()
		elseif moment == 5 then
			moment=6
			bg5.isVisible=true
			blockTouch()
		elseif moment == 6 then
			moment=7
			bg6.isVisible=true
			blockTouch()
		elseif moment == 7 then
			moment=8
			bg7.isVisible=true
			blockTouch()
		elseif moment == 8 then
			moment=9
			bg8.isVisible=true
			blockTouch()
		elseif moment == 9 then
			moment=10
			bg9.isVisible=true
			blockTouch()
		elseif moment == 10 then
			moment=1
			blockTouch()
			changeScene()
		end	
	end
	return true
end

function scene:create( event )

	local sceneGroup = self.view

	background = display.newImageRect( scenePath.."6.jpg", _W, _H )
	background.anchorX = 0 
	background.anchorY = 0
	

	bg1 = display.newImageRect( scenePath.."7.jpg", _W, _H )
	bg1.anchorX = 0 
	bg1.anchorY = 0

	bg2 = display.newImageRect( scenePath.."8.jpg", _W, _H )
	bg2.anchorX = 0 
	bg2.anchorY = 0
	
	bg3 = display.newImageRect( scenePath.."9.jpg", _W, _H )
	bg3.anchorX = 0 
	bg3.anchorY = 0

	bg4 = display.newImageRect( scenePath.."10.jpg", _W, _H )
	bg4.anchorX = 0 
	bg4.anchorY = 0

	bg5 = display.newImageRect( scenePath.."11.jpg", _W, _H )
	bg5.anchorX = 0 
	bg5.anchorY = 0
	
	bg6 = display.newImageRect( scenePath.."12.jpg", _W, _H )
	bg6.anchorX = 0 
	bg6.anchorY = 0

	bg7 = display.newImageRect( scenePath.."13.jpg", _W, _H )
	bg7.anchorX = 0 
	bg7.anchorY = 0

	bg8 = display.newImageRect( scenePath.."14.jpg", _W, _H )
	bg8.anchorX = 0 
	bg8.anchorY = 0
	
	bg9 = display.newImageRect( scenePath.."15.jpg", _W, _H )
	bg9.anchorX = 0 
	bg9.anchorY = 0

	sceneGroup:insert( background )
	sceneGroup:insert( bg1 )
	sceneGroup:insert( bg2 )
	sceneGroup:insert( bg3 )
	sceneGroup:insert( bg4 )
	sceneGroup:insert( bg5 )
	sceneGroup:insert( bg6 )
	sceneGroup:insert( bg7 )
	sceneGroup:insert( bg8 )
	sceneGroup:insert( bg9 )

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen

		bg1.isVisible = false
		bg2.isVisible = false
		bg3.isVisible = false
		bg4.isVisible = false
		bg5.isVisible = false
		bg6.isVisible = false
		bg7.isVisible = false
		bg8.isVisible = false
		bg9.isVisible = false

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
		bg1.isVisible = false
		bg2.isVisible = false
		bg3.isVisible = false
		bg4.isVisible = false
		bg5.isVisible = false
		bg6.isVisible = false
		bg7.isVisible = false
		bg8.isVisible = false
		bg9.isVisible = false
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