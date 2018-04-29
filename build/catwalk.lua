-- catwalk program

local args = {...}

-- Check number of arguments for usage
if #args ~= 1 then
	print( "Argument required for length of run." )
	exit()
end

local i = 0
while i < tonumber(args[1]) do

	-- move forward
	if not turtle.detect() then
		turtle.forward()
	end

	-- place under, building
	if not turtle.detectDown() then
		turtle.placeDown()
	end

	i = i + 1

end


