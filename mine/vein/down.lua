local success, data = turtle.inspectDown()
if not success then
  error("No block found.")
end
local count = mine.vein({name=data.name})


print("Mined " .. tostring(count) .. " " .. data.name)
