-- inventory/count program
local args = {...}
BLOCK = (#args > 0 and tonumber(args[1]) or nil)
print(inventory.drop(BLOCK))
