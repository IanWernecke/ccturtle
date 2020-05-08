-- compare a table with another table
local compare_resource_map_value_to_resource = function(resource_map_value, resource)

  for key, value in pairs(resource_map_value) do
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
    elseif type(value) == "number" then
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


-- converty a recipe to an item if possible, for display purposese
-- return: table (item)
local to_item = function(recipe)

  for item_key, recipe_value in pairs(con.RECIPES) do
    if con[item_key] ~= nil and common.tables_equal(recipe_value, recipe) then
      return con[item_key]
    end
  end
  return nil

end

local to_recipe = function(item)

  for item_key, recipe_value in pairs(con.RECIPES) do
    if con[item_key] ~= nil and common.tables_equal(item, con[item_key]) then
      return recipe_value
    end
  end
  return nil

end


-- Attempt to craft a given recipe, using a pair of chests.
-- return: boolean success
function craft(recipe, num)

  reset()

  -- get the number of times to craft the recipe
  num = opt.get(num, 1)

  local debug_item = to_item(recipe)
  if debug_item == nil then
    common.table_print(string.format("Trying to craft recipe (%d)", num), recipe)
    -- print(string.format("Trying to craft recipe (%d): %s", num, common.table_format(recipe))))
  else
    common.table_print(string.format("Trying to craft item (%d)", num), recipe)
    -- print(string.format("Trying to craft item (%d): %s", num, common.table_format(debug_item)))
  end

  -- begin getting a handle on the recipe requirements
  -- local layout = arg.get(recipe, 1, nil)
  local resource_map = arg.get(recipe, 2, nil)

  -- ensure the recipe layout and the resource map were found in the recipe
  -- if layout == nil then error("Recipe layout not found.") end
  if resource_map == nil then error("Recipe resource map not found.") end

  -- create the list of resources from the resource map
  local resources = {}
  for _, value in pairs(resource_map) do
    table.insert(resources, value)
  end

  -- calculate how many of each item is required
  local materials = inventory.calculate_materials(recipe, num)

  -- while the inventory does not contain all of the resources
  -- there is a bug in this in that some resources will be required multiple times
  -- something should be done with the materials
  while not inventory.contains_materials(materials) do

    -- filter objects from the chest in front to the chest above
    while turtle.suck() do
      if inventory.matches(resources, index) then
        -- keep the inventory objects to a minimum
        inventory.limit_materials(materials, turtle.dropUp)
        inventory.select_first_empty()
      else
        turtle.dropUp()
      end
    end

    -- if the inventory does not contain the required resources,
    -- determine which are missing and try to craft them
    for resource, resource_count in pairs(materials) do
      if inventory.count(resource) < resource_count then

        -- local missing_count = req_count - inv_count
        -- common.table_print(string.format("Missing %d resource(s)", missing_count), resource)

        -- if there is no recipe for the missing item, error
        local item_recipe = to_recipe(resource)
        if item_recipe == nil then
          reset()
          common.table_print("No recipe found for resource", resource)
          return false
        end

        -- try to create the sub component (giving the number of times the resource is needed)
        -- note, as count of items is not yet accounted for, this will over-produce simple components
        -- WARNING: crafting multiple at a time has been disabled due to complexity of determining
        --  count of number of items produced by a recipe and determining required ingredients when
        --  some ingredients take damage instead of being used (like hammers, cutters)
        if not craft(item_recipe) then
          common.table_print("Failed to create required sub-component", resource)
          return false
        end

        print("Successfully created %d sub-component(s)!")

      end
    end

  end

  -- debugging
  common.table_print("Resources obtained for recipe", recipe)

  -- limit the resources to only those required for the recipe
  inventory.limit_materials(materials)

  -- sort all of the items in the inventory towards the end for ease of movement
  -- note: this does not do any degragging at this time (count 1 will sit next to count 1)
  inventory.pack_bottom()

  -- distribute the materials for the recipe
  inventory.distribute_materials(recipe, num)

  local result = turtle.craft()
  reset()

  -- if the result failed, print some information for debugging
  if not result then
    print("Failed to craft recipe!")
    local resource = to_item(recipe)
    if resource ~= nil then
      print_resource(resource)
    end
    return false
  end

  return result

end
