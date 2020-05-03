-- inventory/select program
local args = {...}

-- check number of arguments for usage
if #args ~= 1 then
    error("Usage: BLOCK_DATA_NAME")
end

slot = inventory.find(args[1])
if slot == nil then
  error("Unable to find resource: " .. args[1])
end
turtle.select(slot)
