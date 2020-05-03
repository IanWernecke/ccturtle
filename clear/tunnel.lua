-- catwalk program

local args = {...}

-- check number of arguments for usage
if #args ~= 1 then
	print( "Argument required for length of run." )
	exit()
end

clear.tunnel( tonumber(args[1]) )
