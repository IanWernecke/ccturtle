#!/bin/lua

-- wall program
local args = {...}


-- Check number of arguments for usage
if #args ~= 1 then
    print( "Argument required for length of wall." )
    exit()
end


-- build a wall 4 high
local wall_height = 4
local wall_length = tonumber(args[1])

for i = 1, wall_length do

    -- place the wall under us
    for j = 1, wall_height do
        turtle.up()
        turtle.placeDown()
    end

    turtle.forward()
    move.seekDown()

end
