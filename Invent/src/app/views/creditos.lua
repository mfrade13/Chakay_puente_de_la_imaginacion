-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

local btnPath = "src/imagenes/botones/"
-- include Corona's "physics" library
local _W, _H, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

--------------------------------------------

-- forward declarations and other locals
local _W, _H, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX
local backBtn, background

local function onBackBtnRelease()
	-- go to level1.lua scene
	composer.gotoScene( "menu", "fade", 500 )
	return true	-- indicates successful touch
end

function scene:create( event )

	local sceneGroup = self.view

	background = display.newImageRect( "src/imagenes/backgrounds/creditos.jpg" ,_W,_H )
	background.anchorX = 0 
	background.anchorY = 0
	
		backBtn = widget.newButton{
			defaultFile  ="".. btnPath .."atras.png",
			overFile ="" .. btnPath .."atras_over.png",
			width=56, height=56,
			onRelease = onBackBtnRelease	-- event listener function
		}
		backBtn.x = _W-40
		backBtn.y = 20

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( backBtn )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		
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
	

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene