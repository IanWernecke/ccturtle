-- strafe/left program

local args = {...}

-- Check number of arguments for usage
if #args == 1 then
    distance = tonumber(args[1])
else
    distance = 1
end

move.left(distance)
turtle.turnRight()
