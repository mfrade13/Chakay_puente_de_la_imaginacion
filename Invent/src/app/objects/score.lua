module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight


local font = "richela"

local counter


function new_score( )
	local group = display.newGroup( )
	local initial_value =0
	local score_text = display.newText( group, "SCORE: " , 0, 0, 150, 60, font ,14 )
	score_text:setFillColor(144/255, 242/255 , 238/255)

	local num_text = display.newText( group, "", score_text.x+20, score_text.y-4, 100,60 , font,18 ,"left" )
	num_text:setFillColor(144/255, 242/255 , 238/255) 

	function group:reset_score(  )
		initial_value = 0
		num_text.text = "" .. initial_value
	end

	function group:increase(rate)
		initial_value = initial_value + rate
		num_text.text = "" .. initial_value
	end

	function group:get_score( )
		return initial_value
	end

	function group:scalePoints( )
		num_text.xScale = 3.0
		num_text.yScale = 3.0
		num_text.x = _W/2
		num_text.y = _H/2
	end

	function group:reset( )
		initial_value = 0
		num_text.text = "" .. initial_value
		num_text.y = score_text.y-4
		num_text.x = score_text.x+20
		num_text.xScale = score_text.xScale
		num_text.yScale = score_text.yScale
	end

	return group
end