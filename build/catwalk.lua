#!/bin/lua


-- catwalk program
local args = {...}

-- check number of arguments for usage
if #args ~= 1 then
    print( "Argument required for length of run." )
    exit()
end


local max = tonumber(args[1])
for i = 1, max do

  -- move forward
  if not turtle.detect() then
    turtle.forward()
  end

  -- place under, building
  if not turtle.detectDown() then
    turtle.placeDown()
  end

end
