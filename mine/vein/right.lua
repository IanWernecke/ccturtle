turtle.turnRight()

local data = turtle.inspect()
local count = mine.vein(data.name)

turtle.turnLeft()

print("Mined " .. tostring(count) .. " " .. data.name)
