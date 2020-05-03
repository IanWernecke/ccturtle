local data = turtle.inspect()
local count = mine.vein(data.name)

print("Mined " .. tostring(count) .. " " .. data.name)
