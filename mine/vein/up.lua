local data = turtle.inspectUp()
local count = mine.vein(data.name)

print("Mined " .. tostring(count) .. " " .. data.name)
