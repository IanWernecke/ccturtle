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
	turtle.turnLeft()

else

	turtle.turnRight()

end

move.magnet()

turtle.turnRight()
turtle.back()
turtle.down()

clear.spiralRight()
