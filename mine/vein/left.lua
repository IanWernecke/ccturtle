turtle.turnLeft()

local success, data = turtle.inspect()
if not success then
  error("No block found.")
end
local count = mine.vein({name=data.name})


turtle.turnRight()

print("Mined " .. tostring(count) .. " " .. data.name)
