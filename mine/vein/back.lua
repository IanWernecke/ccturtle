turtle.turnLeft()
turtle.turnLeft()

local data = turtle.inspect()
local count = mine.vein(data.name)

turtle.turnLeft()
turtle.turnLeft()

print("Mined " .. tostring(count) .. " " .. data.name)
