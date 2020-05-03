-- move/right program
-- move 1 or the designated number to the right

local args = {...}

-- Check number of arguments for usage
if #args == 1 then
	distance = tonumber(args[1])
else
	distance = 1
end

move.right(distance)
