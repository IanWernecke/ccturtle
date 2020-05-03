#!/bin/lua

-- catch arguments given on command line
local args = {...}
local limit = nil

-- check number of arguments for usage
if #args == 1 then
	limit = tonumber(args[1])
else
	print("A distance is required.")
  return(1)
end

-- dig the tunnel
local distance = 0
local height = 3
while distance < limit do

  dig.forward()

  -- orient left
  turtle.turnLeft()
  local index = 0

  -- upwards
  clear.forward()
  while index < height do
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

  distance = distance + 1

end
