local args = {...}
local num = 0

if #args == 1 then
    num = tonumber(args[1])
else
    num = 1
end

move.down(num)
