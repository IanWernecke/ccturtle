-- catch arguments given on command line 
local args = {...}

-- check number of arguments for usage
if #args == 1 then
	arg = tonumber(args[1])
else
	arg = nil
end

-- call the required function
-- move.forward(arg)
