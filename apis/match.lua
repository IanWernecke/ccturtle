-- api core logic
-- logic to match the block using inspection
local match_logic = function(resource, action)

  local success, data = action()

  -- if failed to inspect, no match
  if not success then
    return false
  end

  -- convert the variable to a table if it is a string
  if type(resource) == "string" then
    resource = {name=resource}
  end

  -- compare each key in the resource to the detail found on the index
  for key, value in pairs(resource) do
    if not data[key] or data[key] ~= value then
      return false
    end
  end

  return true

end


-- series of commands to test strings against connected blocks
function back(resource)
    turtle.turnLeft()
    turtle.turnLeft()
    return forward(resource)
end
function forward(resource)
    return match_logic(resource, turtle.inspect)
end
function down(resource)
    return match_logic(resource, turtle.inspectDown)
end
function left(resource)
    turtle.turnLeft()
    return forward(resource)
end
function right(resource)
    turtle.turnRight()
    return forward(resource)
end
function up(resource)
    return match_logic(resource, turtle.inspectUp)
end
