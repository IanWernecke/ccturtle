-- notes
--  1. "resource" variable names are supposed to be tables that specify values to be matched
--    against inventory item details


-- determine what recipe should go in a give slot according to the given recipe
-- return: table (ITEM_*)
local recipe_resource = function(recipe, slot)
  local row_index = math.floor(slot / 4)
  local col_index = math.mod(slot, 4)
  return recipe[2][
    recipe[1][row_index]:sub(col_index, col_index)
  ]
end


-- return an array of the slots that require resources
-- return: table {slot[, slot[, slot]]}
local recipe_slots = function(recipe)

  local slots = {}
  for row_index = 1, #recipe[1] do
    local row = recipe[1][row_index]
    for char_index = 1, #row do
      local char = row:sub(char_index, char_index)
      if char ~= "." then
          slots.insert(slots, ((row_index - 1) * 4) + char_index)
      end
    end
  end
  return slots

end


-- walk the recipe and determine where the destinations are for the resources
-- return: table {slot=resource[, slot=resource]}
local recipe_walk = function(recipe)

  local slot_resource_table = {}
  for row_index = 1, #recipe[1] do
    local row = recipe[1][row_index]
    for char_index = 1, #row do

      local char = row:sub(char_index, char_index)
      if char ~= "." then
        slot_resource_table[((row_index - 1) * 4) + char_index] = recipe[2][char]
      end

    end
  end
  return slot_resource_table

end


-- calculate how many of each item is required
-- return: table (dict) {item: number}
function calculate_materials(recipe, number)

  number = opt.get(number, 1)

  -- calculate how many of each item is required
  materials = {}

  -- calculate how many of each item is required
  for _, resource in pairs(recipe_walk(recipe)) do
    if materials[resource] then
      materials[resource] = materials[resource] + number
    else
      materials[resource] = number
    end
  end

  return materials

end


-- function: contains
-- param string_id: the name of the block to search for in inventory
-- return: boolean
function contains(string_id, number)

  number = opt.get(number, 1)

  -- find the slot that contains the resource
  local slot = find(string_id)
  if slot == nil then
    return false
  end

  -- slot is not nil, if count == 1, then return true
  if count == 1 then
    return true
  end

  -- ensure the slot contains the required amount
  return (count(string_id) >= number and true or false)

end


-- determine whether the inventory contains the required amount
-- of each resource given in resources
-- return: boolean
function contains_all(resources, number)

  number = opt.get(number, 1)

  -- search for each of the resources given and ensure they have the requires amount
  for index = 1, #resources do
    if number == 1 then
      if find(resources[index]) == nil then return false end
    else
      if count(resources[index]) < number then return false end
    end
  end
  return true

end


-- determine whether the inventory contains at least the given
-- number of materials specified
-- example:
--  contains_materials({con.ITEM_LOG=2})
-- should result in true for a turtle with a count of logs equal or
-- greater than 2 in the turtle's inventory
-- return: boolean
function contains_materials(materials)

  -- make a copy of the given materials table so we can modify
  -- it without destroying the original
  local missing = {}
  for k, v in pairs(materials) do missing[k] = v end

  -- for each slot which contains anything
  for _, slot in pairs(find_all()) do

    -- walk each resource and determine if it matches
    for resource, missing_count in pairs(missing) do
      if match(resource, slot) then

          -- reduce the missing count towards 0
          item_count = turtle.getItemCount(slot)
          if item_count > missing_count then
            missing[resource] = 0
          else
            missing[resource] = missing_count - item_count
          end
          break

      end
    end

  end

  -- if all of the values in the missing table are 0, return true
  for _, missing_count in pairs(missing) do
    if missing_count > 0 then return false end
  end
  return true

end


-- count all of the items in the inventory that match the given
-- resource details table, or all of nil is given
function count(resource)

  -- ensure we are working with a good resource
  resource = to_resource(resource)

  -- iterate each of the slots and add values that match the given
  -- resource, or all of resource is not given
  local total = 0
  for slot = 1, 16 do
    if match(resource, slot) then
      total = total + turtle.getItemCount(slot)
    end
  end
  return total

end


-- distribute $num resources to each slot in the recipe
-- return: boolean success
function distribute_materials(recipe, num)

  num = opt.get(num, 1)

  -- walk each slot and resource in the recipe
  -- for slot, resource in pairs(recipe_walk(recipe)) do
  local slots = recipe_slots(recipe)
  for slot_index = 1, #slots do

    -- convenient references for the places to move around
    local slot = slots[slot_index]
    local resource = recipe_resource(recipe, slot)

    -- stock the slot that requires the resource
    local item_count = turtle.getItemCount(slot)
    while item_count < num do

      -- find the last inventory slot with the resource for the resource source
      local last_slot = last(resource)
      if last_slot == nil then
        print(string.format("Failed to find last slot of resource: %s", common.table_format(resource)))
        return false
      end

      if slot == last_slot then
        print(string.format("Out of materials while distributing to slot: %d", slot))
        return false
      end

      -- move the required number of items to the slot
      result = move(last_slot, slot, num - item_count)
      if not result then
        print(string.format("Failed to move resources from slot %d to slot %d", last_slot, slot))
        return false
      end
      item_count = turtle.getItemCount(slot)

    end

    -- pack all items down after the current slot
    inventory.pack_bottom(slot + 1)

  end
  return true

end


-- function: drop
-- param slot: the slot number to drop forward
-- return: bool success
function drop(slot, turtle_drop, count)

  -- set the default drop direction to forwards and the number of items to drop
  turtle_drop = opt.get(turtle_drop, turtle.drop)
  count = opt.get(count, nil)

  -- store this for later
  starting_slot = turtle.getSelectedSlot()

  -- if a slot was given, drop only that one and return
  if slot ~= nil then
    turtle.select(slot)
    local result = turtle_drop(count)
    turtle.select(starting_slot)
    return result
  end

  -- drop all of the items in the inventory
  for slot = 1, 16 do
    if turtle.getItemCount(slot) > 0 then
      turtle.select(slot)
      turtle_drop()
    end
  end

  -- select the original slot and return true
  turtle.select(starting_slot)
  return true

end


-- empty a slot in the inventory
-- return: the number of items removed from the position
function empty_slot(slot, drop_action)

  -- optional parameters
  drop_action = opt.get(drop_action, turtle.drop)

  -- get the result value
  local count = turtle.getItemCount(slot)

  -- if the position is already empty, return true
  if count == 0 then
    return true
  end

  -- prefer moving items to an empty slot over dropping
  local next_empty_slot = find_empty_slot()
  if next_empty_slot == nil then
    drop(slot)
  else
    move(slot, next_empty_slot)
  end

  return count

end


-- attempt to find the first open slot in the inventory
-- return: a slot number that has no items, or nil if everything is full
function find_empty_slot()
    for index = 1, 16 do
      if turtle.getItemCount(index) == 0 then return index end
    end
    return nil
end


-- look for an exact match for a given resource in the inventory
-- parameter resources: table that describes the required items details
function find(resource)

  -- ensure we are working with a table
  resource = to_resource(resource)

  -- return the first occurance of a found resource
  for index = 1, 16 do
    if match(resource, index) then return index end
  end

  -- not found, return nil
  return nil

end


-- find all of the slots that match the specified resource
-- return: table (list)
function find_all(resource)

  -- ensure we are working with a table
  resource = to_resource(resource)

  local result = {}
  for index = 1, 16 do
    if match(resource, index) then table.insert(result, index) end
  end
  return result

end


-- find the first empty slot in the inventory
-- return: number | nil
function find_first_empty_slot()
  for slot = 1, 16 do
    if turtle.getItemCount(slot) == 0 then return slot end
  end
  return nil
end


-- find the last empty slot in the inventory
-- return: number | nil
function find_last_empty_slot()
  for index = 16, 1, -1 do
    if turtle.getItemCount(index) == 0 then return index end
  end
  return nil
end


-- function: first
-- return: returns the first inventory slot with items in it
function first()

    for index = 1, 16 do
        if 0 < turtle.getItemCount(index) then return index end
    end
    error("Unable to find any items in inventory.")

end


-- find the last instance of the given resource
-- (or the first that has something)
-- return: number | nil
function last(resource)

  -- ensure we are working with a table
  resource = to_resource(resource)

  -- walk each inventory slot backwards and attempt to match
  for slot = 16, 1, -1 do
    if match(resource, slot) then
      return slot
    end
  end

  -- no slot that matches found, return nil
  return nil

end


-- limit the items in the inventory to the specific amounts
-- specified in the materials table
-- example:
--  limit_materials({con.ITEM_LOG=2})
-- should drop all items from the inventory except 2 logs
-- return: (bool) success
function limit_materials(materials, drop_action)

  -- optional parameters
  drop_action = opt.get(drop_action, turtle.drop)

  -- make a copy of the given materials table so we can modify
  -- it without destroying the original
  local keep = common.table_copy(materials)

  -- walk all of the slots that have anything in them
  for _, slot in pairs(find_all()) do

    -- keep track of whether the slot matched any of the resources
    local slot_matched = false

    -- try to match each resource against the slot being walked
    for resource, require_count in pairs(keep) do
      if match(resource, slot) then

        -- if we do not require any more of this resource, pretend it matches nothing
        if require_count == 0 then
          break
        end

        -- keep track of whether the slot matched anything
        slot_matched = true

        -- we require some more, determine how many to keep
        local item_count = turtle.getItemCount(slot)

        -- if we need all of them, reduce the required count by the item count and break
        if require_count >= item_count then
          keep[resource] = require_count - item_count
          break
        end

        -- if the items in the stack are fewer than those required, drop some
        local starting_slot = turtle.getSelectedSlot()
        turtle.select(slot)
        drop_action(item_count - require_count)
        keep[resource] = 0
        turtle.select(starting_slot)
        break

      end
    end

    -- if the slot did not match anything, drop it
    if not slot_matched then
      local starting_slot = turtle.getSelectedSlot()
      turtle.select(slot)
      drop_action()
      turtle.select(starting_slot)
    end

  end

  -- determine whether all of the materials required were found
  for _, count in pairs(keep) do
    if count > 0 then return false end
  end
  return true


end


-- determine whether a given slot matches a given resource table
-- return: boolean
function match(resource, slot)

  -- get the detail of the item in slot(index)
  -- if slot is not given, the current slot will be used
  local detail = turtle.getItemDetail(slot)

  -- if not data was obtained, the call was empty -- never match
  if detail == nil then return false end

  resource = to_resource(resource)

  -- compare each key in the resource to the detail found on the index
  for key, value in pairs(resource) do
    if not detail[key] or detail[key] ~= value then
      return false
    end
  end

  return true

end


-- determine whether one of the given resources matches the slot (or current if nil)
-- return: boolean
function matches(resources, slot)

  slot = opt.get(slot, nil)

  local detail = turtle.getItemDetail(slot)

  -- nothing found, return false
  if detail == nil then return false end

  -- walk each resource given
  for index = 1, #resources do
    local resource = to_resource(resources[index])

    -- compare each key value against the details, set result to false if no match
    local result = true
    for key, value in pairs(resource) do
      if not detail[key] or detail[key] ~= value then
        result = false
        break
      end
    end

    -- if the details matched the resource
    if result then return true end

  end

  return false

end


-- move items from one slot to another
-- return: boolean success
function move(source, destination, number)

  local position = turtle.getSelectedSlot()
  turtle.select(source)
  local result = turtle.transferTo(destination, number)
  turtle.select(position)
  return result

end


-- move all inventory items above the given slot towards the end of the inventory
function pack_bottom(first_slot)

  first_slot = opt.get(first_slot, 1)

  -- keep track of the number of slots moved and where the last empty slot appears to be
  local moved = 0
  local last_empty_slot = inventory.find_last_empty_slot()

  -- walk from the first slot given to the end (inclusive of 16)
  for slot = first_slot, 16 do

    -- break out if the pack is complete
    if slot > last_empty_slot then
      break
    end

    -- slot is before the last empty slot
    if turtle.getItemCount(slot) > 0 then
      local result = inventory.move(slot, last_empty_slot)
      if not result then
        error(string.format("Failed to move resource from slot %d to slot %d", slot, last_empty_slot))
      end
      moved = moved + 1
      last_empty_slot = inventory.find_last_empty_slot()
    end

  end

  -- return the number of slots moved
  return moved

end


-- try to select the first empty slot
-- return: boolean success
function select_first_empty()

  -- try to find the first empty slot
  local empty_slot = inventory.find_first_empty_slot()
  if empty_slot == nil then
    print("Failed to find empty slot!")
    return false
  end

  -- try to select the slot
  local result = turtle.select(empty_slot)
  if result == false then
    print(string.format("Failed to select slot: %d!", empty_slot))
    return false
  end

  return true

end


-- convert the given input to table if it is a string,
-- otherwise,
function to_resource(resource)

  -- check for table first, for fewer comparisons
  if type(resource) == "table" then
    return resource
  end

  -- convert a nil value to an empty table
  if resource == nil then
    return {}
  end

  -- convert a string value to a simple table (old fashion)
  if type(resource) == "string" then
    return {name=resource}
  end

  print(resource)
  error("Unrecognized resource!")

end
