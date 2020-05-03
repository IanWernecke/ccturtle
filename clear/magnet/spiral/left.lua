-- clear/magnet-spiral-left.lua

move.magnet()

-- hit object in front
if turtle.detect() then

	turtle.up()

	-- probably not good
	if turtle.detect() then
		turtle.down()
		shell.exit()
	end

	turtle.forward()
	turtle.turnRight()

else

	turtle.turnLeft()

end

move.magnet()

turtle.turnLeft()
turtle.back()
turtle.down()

clear.spiralLeft()
