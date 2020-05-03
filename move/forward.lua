-- catch arguments given on command line 
local args = {...}

-- check number of arguments for usage
if #args == 1 then
	distance = tonumber(args[1])
else
	distance = 1
end

move.forward(distance)
