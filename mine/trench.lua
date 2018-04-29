-- catwalk program

local args = {...}

-- Check number of arguments for usage
if #args ~= 1 then
	print( "Argument required for length of one-deep trench." )
	exit()
end

-- the length of the one-deep trench we should dig
i = 0
max = tonumber(args[1])
while i < max do

	if turtle.detectDown() then
		turtle.digDown()
	end
	turtle.forward()

	i = i + 1

end

