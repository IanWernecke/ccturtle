local success, data = turtle.inspectUp()
if not success then
  error("No block found.")
end

local count = mine.vein({name=data.name})

print("Mined " .. tostring(count) .. " " .. data.name)
