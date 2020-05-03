local data = turtle.inspectUp()
local count = mine.vein({name=data.name})

print("Mined " .. tostring(count) .. " " .. data.name)
