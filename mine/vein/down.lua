local data = turtle.inspectDown()
local count = mine.vein(data.name)

print("Mined " .. tostring(count) .. " " .. data.name)
