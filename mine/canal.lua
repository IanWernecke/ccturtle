#!/bin/lua

local height = 3
while turtle.detect() do

  dig.forward()

  -- orient left
  turtle.turnLeft()
  local index = 0

  -- upwards
  clear.forward()
  while index < height and turtle.detectUp() do
    dig.up()
    clear.forward()
    index = index + 1
  end

  -- spin around
  turtle.turnRight()
  turtle.turnRight()

  -- downwards
  while index > 0 do
    clear.forward()
    turtle.down()
    index = index - 1
  end
  clear.forward()

  -- face forward
  turtle.turnLeft()

end
