-- catwalk program

local args = {...}

-- Check number of arguments for usage
if #args ~= 1 then
	print( "Argument required for length of wall." )
	exit()
end

for i,v in ipairs(args) do
	print( "argument #" .. i .. " is:" .. v )
end

-- build a wall 4 high
local wall_height = 4
local wall_length = tonumber(args[1])

local i = 0
while i < wall_length do

	-- place the wall under us
	local j = 0
	while j < wall_height do
		turtle.up()
		turtle.placeDown()
		j = j + 1
	end

	turtle.forward()
	move.seekDown()

	i = i + 1

end

