-- basic program
local args = {...}

-- check number of arguments for usage
if #args == 1 then
  turtle.select(tonumber(args[0]))
end

local data = turtle.getItemDetail()
if data then
  print("Item name: ", data.name)
  print("Item damage value: ", data.damage)
  print("Item count: ", data.count)
end
