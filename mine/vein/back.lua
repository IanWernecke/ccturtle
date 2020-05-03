turtle.turnLeft()
turtle.turnLeft()

local success, data = turtle.inspect()
if not success then
  error("No block found.")
end
local count = mine.vein({name=data.name})

turtle.turnLeft()
turtle.turnLeft()

print("Mined " .. tostring(count) .. " " .. data.name)
