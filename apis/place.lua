-- program apis/place_logic
-- logic to place_logic the next available block
local place_logic = function(resource, action_command)

  -- select the specific place string if it is not already selected
  if not inventory.match(resource) then
    local res = inventory.find(resource)
    assert(res ~= nil, "Inventory does not contain: " .. resource)
    turtle.select(res)
  end

  -- if able to place_logic block, success!
  if action_command() then
    return true
  end

  -- selection was depleted, ensure blocks are available
  turtle.select(inventory.first())
  return action_command()

end


-- series of commands to always place_logic any available blocks (after current spot)
function back(resource)
    turtle.turnLeft()
    turtle.turnleft()
    return forward(resource)
end
function forward(resource)
    return place_logic(resource, turtle.place)
end
function down(resource)
    return place_logic(resource, turtle.placeDown)
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
    return place_logic(resource, turtle.placeUp)
end
