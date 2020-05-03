turtle.turnLeft()

local data = turtle.inspect()
local count = mine.vein(data.name)

turtle.turnRight()

print("Mined " .. tostring(count) .. " " .. data.name)
