-- read in the arguments given to this script
local args = {...}

-- check number of arguments for usage
if #args == 1 then
	distance = tonumber(args[1])
else
	distance = 1
end

dig.forward(distance)
