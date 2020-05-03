-- notes
--  1. "resource" variable names are supposed to be tables that specify values to be matched
--    against inventory item details


-- function: contains
-- param string_id: the name of the block to search for in inventory
-- return: boolean
function contains(string_id)
    return find(string_id) ~= nil
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


-- function: drop
-- param slot: the slot number to drop forward
-- return: bool success
function drop(slot, turtle_drop)

  -- set the default drop direction to forwards
  turtle_drop = opt.get(turtle_drop, turtle.drop)

  -- if a slot was given, drop only that one and return
  if slot ~= nil then return turtle_drop(slot) end

  -- store this for later
  starting_slot = turtle.getSelectedSlot()

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
function empty(slot, drop_action)

  -- optional parameters
  drop_action = opt.get(drop_action, turtle.drop)

  -- get the result value
  local count = turtle.getItemCount(slot)

  -- if the position is already empty, return true
  if count == 0 then return true end

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


-- function: first
-- return: returns the first inventory slot with items in it
function first()

    for index = 1, 16 do
        if 0 < turtle.getItemCount(index) then return index end
    end
    error("Unable to find any items in inventory.")

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
function move(source, destination)

  local position = turtle.getSelectedSlot()
  turtle.select(source)
  local result = turtle.transferTo(destination)
  turtle.select(position)
  return result

end


-- convert the given input to table if it is a string,
-- otherwise,
function to_resource(resource)

  -- check for table first, for fewer comparisons
  if type(resource) == "table" then return resource end

  -- convert a nil value to an empty table
  if resource == nil then return {} end

  -- convert a string value to a simple table (old fashion)
  if type(resource) == "string" then return {name=resource} end

  print(resource)
  error("Unrecognized resource!")

end
