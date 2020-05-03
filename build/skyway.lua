#!/bin/lua

-- catch arguments given on command line
local args = {...}

-- check number of arguments for usage
if #args ~= 1 then
    print("Argument required for length of run.")
    return 1
end


-- local function for building an edge to the skyway
local build_edge = function(turn_to, turn_back)
  turn_to()
  local index = 0
  while index < 2 do

    -- wall encountered, stop
    if detect.forward() then break end

    -- move forward and attempt to place down if empty
    move.forward()
    if not detect.down() then place.down() end
    index = index + 1
    
  end
  move.back(index)
  turn_back()
end


-- perform the building
local count = 0
local max = tonumber(args[1])
while count < max do

  -- facing forward, ensure below
  if not detect.down() then place.down() end

  -- place left 2 blocks and right two blocks if possible
  build_edge(turtle.turnLeft, turtle.turnRight)
  build_edge(turtle.turnRight, turtle.turnLeft)

  -- move forward or break
  if detect.forward() then
    break
  else
    move.forward()
  end

  count = count + 1

end
