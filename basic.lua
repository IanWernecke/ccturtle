-- description:
-- 	basic program stub


-- collect the arguments from the command line
local args = {...}


-- check number of arguments for usage
if #args ~= 1 then
	error( "Argument required for length of run." )
end


-- perform the work
for i,v in ipairs(args) do
	print( "argument #" .. i .. " is:" .. v )
end
