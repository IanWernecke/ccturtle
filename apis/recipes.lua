
-- compare a table with another table
local compare_resource_map_value_to_resource = function(resource_map_value, resource)

  for key, value in pairs(resource_map_value) then
    if not resource[key] or resource_map_value[key] ~= resource[key] then
      return false
    end
  end
  return true

end


-- print a table that describes a resource
local print_resource = function(resource)

  print('Resource:')
  for key, value in pairs(resource) do
    if type(value) == "string" then
      print(string.format("  %s: %s", key, value))
    elseif type(value) == "int" then
      print(string.format("  %s: %d", key, value))
    else
      error(string.format("Unhandled value type: %s", type(value)))
    end
  end

end


-- move all of the materials from the inventory to the chest in front and
-- the items from the above chest to the chest forwards
-- return: nil
local reset = function()

  -- ensure a chest is in front and on top of the turtle
  if not match.forward(con.BLOCK_CHEST) then
    error("No chest detected in front of turtle.")
  end
  if not match.up(con.BLOCK_CHEST) then
    error("No chest detected above turtle.")
  end

  -- drop everything from the inventory
  inventory.drop()

  -- move everything from the chest above to the chest in front
  turtle.select(1)
  while turtle.suckUp() do
    turtle.drop()
  end

end


-- calculate how many of each item is required
-- return: table (dict) {item: int}
function count_required_materials(layout, resource_map, number)

  number = opt.get(number, 1)

  -- calculate how many of each item is required
  materials = {}

  for row_index = 1, #layout do
    local row = layout[row_index]
    for char_index = 1, #row do

      local char = row:sub(char_index, char_index)
      if char ~= "." then
        local material = resource_map[char]
        if materials[material] then
          materials[material] = materials[material] + number
        else
          materials[char] = number
        end
      end

    end
  end

  return materials

end


-- find all of the resource slots in the layout for the given resource
-- return: list containing all of the destination slots for the specified resource
function resource_slots(layout, resource_map, resource)

  local slots = {}

  -- for each row and column in the layout
  for row_index = 1, #layout do
    local row = layout[row_index]
    for column_index = 1, #row do

      -- get the character from the string
      local char = row.sub(column_index, column_index)

      -- compare the resource map value to the given resource
      if resource_map[char] and compare_resource_map_value_to_resource(resource_map[char], resource) then
        table.insert(slots, ((row_index - 1) * 4) + column_index)
      end

    end
  end
  return slots

end


-- Attempt to craft a given recipe, using a pair of chests.
-- return: boolean success
function craft(recipe, num)

  reset()

  -- get the number of times to craft the recipe
  num = opt.get(num, 1)

  -- begin getting a handle on the recipe requirements
  local layout = arg.get(recipe, 1, nil)
  local resource_map = arg.get(recipe, 2, nil)

  -- ensure the recipe layout and the resource map were found in the recipe
  if layout == nil then error("Recipe layout not found.") end
  if resource_map == nil then error("Recipe resource map not found.") end

  -- create the list of resources from the resource map
  resources = {}
  for _, value in pairs(resource_map) do
    table.insert(resources, value)
  end

  -- calculate how many of each item is required
  materials = count_required_materials(layout, resource_map, num)

  -- while the inventory does not contain all of the resources
  while not inventory.contains_all(resources, num) do

    -- filter objects from the chest in front to the chest above
    index = 1
    while turtle.suck() do
      if inventory.matches(resources, index) then
        index = index + 1
        turtle.select(index)
      else
        turtle.dropUp()
      end
    end

    -- if the inventory does not contain the required resources,
    -- determine which are missing and try to craft them
    for index = 1, #resources do
      local resource = resources[index]
      if not inventory.contains(resource) then

        -- if there is no recipe for the missing item, error
        if not con.RECIPES[resource] then
          reset()
          print("No recipe found for resource!")
          print_resource(resource)
          return false
        end

        -- try to create the sub component (giving the number of times the resource is needed)
        -- note, as count of items is not yet accounted for, this will over-produce simple components
        if not craft(con.RECIPES[resource], materials[resource]) then
          print("Failed to create required sub-component!")
          print_resource(resource)
          return false
        end

      end
    end

  end

  -- all of the subcomponents exist or have been created, lay out the required and create the primary reciep
  -- at this point, the inventory should only contain items that can go into the recipe
  for index = 1, #resources do

    -- move all of the resource to the end of the inventory
    local first_source_slot = inventory.find(resources[index])
    local last_empty_slot = inventory.find_last_empty_slot()
    while true do

      local first_source_slot = inventory.find(resources[index])
      local last_empty_slot = inventory.find_last_empty_slot()

      -- break out if we are done moving items to the rear
      if first_source_slot > last_empty_slot then
        break
      end

      local result = inventory.move(first_source_slot, last_empty_slot)
      if not result then
          error(string.format("Failed to move resource from slot %d to slot %d", first_source_slot, last_empty_slot))
      end

    end

    -- find the destination slots for the resource
    local resource_src_slots = inventory.find_all(resources[index])
    local resource_dst_slots = resource_slots(layout, resource_map, resources[index])
    if #resource_dst_slots == 0 then
      print("Failed to find resource destination slots for resource!")
      print_resource(resources[index])
      return false
    end

    -- move the resource from the source slot to the destination slot
    local resource_src_slot = nil
    for dst_slot_index = 1, #resource_dst_slots do
      local resource_dst_slot = resource_dst_slots[dst_slot_index]

      -- pop the last src slot off of the src slot list
      if resource_src_slot == nil then
        resource_src_slot = table.remove(resource_src_slots)
      end

      -- while the destination slot does not have the number required
      while turtle.getItemCount(resource_dst_slot) ~= num do

        -- if the src slot is empty, pop the next slot off of the src slot stack
        if turtle.getItemCount(resource_src_slot) == 0 then
          resource_src_slot = table.remove(resource_src_slots)
        end

        -- move only the number required to the destination slot
        inventory.move(resource_src_slot, resource_dst_slot, num - turtle.getItemCount(resource_dst_slot))

      end

    end

    -- drop the current resource src slots
    while #resource_src_slots > 0 do
      if turtle.getItemCount(resource_src_slot) > 0 then
        inventory.drop(resource_src_slot)
      end
      resource_src_slot = table.remove(resource_src_slots)
    end

  end

  return turtle.craft()

end
