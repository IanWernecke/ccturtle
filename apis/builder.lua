#!/usr/bin/lua


-- description:
--  this api is written to provide basic building utilities
-- requires:
--  clear, dig, match, move, place


-- this function creates a materials map
local count_materials = function(building)

  materials = {}

  -- if the building has no layers, return the empty table
  if #building == 0 then return materials end

  -- count each of the materials needed in the building
  for layer_index = 1, #building do
    local layer = building[layer_index]
    for row_index = 1, #layer do
      local row = layer[row_index]
      for char_index = 1, #row do

        -- increment the found character value by one if it is not "."
        local char = row:sub(char_index, char_index)
        if char ~= "." then
          if materials[char] then
            materials[char] = materials[char] + 1
          else
            materials[char] = 1
          end
        end

      end
    end
  end

  -- return the table of our counted values
  return materials

end


-- this function determines if a row has nothing to build
local has_content = function(row)
  return #row > 0 and row:match("%.+") ~= row
end


-- set the row of blocks in front of the turtle (and below) to
-- contain or be empty of blocks
local build_row = function(row, materials)

  local count = 0
  for char_index = 1, #row do

      local char = row:sub(char_index, char_index)
      if char == "." then
        clear.down()
      else
        if materials == nil then
          if not turtle.detectDown() then
            place.down()
            count = count + 1
          end
        else
          if turtle.detectDown() and match.down(materials[char]) == false then
            clear.down()
          end
          place.down(materials[char])
          count = count + 1
        end
      end

      -- dig forward
      if char_index ~= #row then dig.forward() end

  end
  move.back(#row - 1)
  return count

end


-- given an array of strings, build each row in the layer
local build_layer = function(layer, materials)

  dig.up()

  -- if the layer has no rows, return 0
  if #layer == 0 then return 0 end

  local layer_count = 0

  -- if the first row has content, build it
  if has_content(layer[1]) then
    build_row(layer[1], materials)
  end

  -- if there is only one row, return now
  if #layer == 1 then return layer_count end

  -- turn to the right
  turtle.turnRight()

  -- for each row in the layer after the first, orient and build
  for row_index = 2, #layer do

    dig.forward()

    -- if the row has something worth building, build it and reorient
    if has_content(layer[row_index]) then
      turtle.turnLeft()
      layer_count = layer_count + build_row(layer[row_index], materials)
      turtle.turnRight()
    end

  end

  -- move back to the starting position
  move.back(#layer - 1)
  turtle.turnLeft()
  return layer_count

end


-- given an array of an array of strings, print an entire building like a 3d printer
function build(building, materials)

  -- if a materials map was not given, simply ensure there are enough materials in the inventory
  if materials == nil then

    -- count the materials in the inventory and sum the values
    local total = 0
    for key, value in pairs(count_materials(building)) do
      total = total + value
    end

    -- count all of the items in the inventory and ensure we have more than the total required
    local count = inv.count()
    if count < total then
      error(string.format("Insufficient materials! [%d/%d]", count, total))
    end

  -- ensure there are enough materials of each type for the print
  else

    local counts = count_materials(building)
    for key, req_count in pairs(counts) do
      local inv_count = inv.count(materials[key])
      if inv_count < req_count then
        error(string.format("Insufficient materials! %s [%d/%d]", materials[value], inv_count, req_count))
      end
    end

  end

  -- for each layer in the building
  local build_count = 0
  for layer = 1, #building do
    build_count = build_count + build_layer(building[layer], materials)
  end

  -- all finished building, return to one space behind starting position, if possible
  turtle.turnLeft()
  turtle.turnLeft()
  if detect.forward() == false then
    move.forward()
  end
  turtle.turnLeft()
  turtle.turnLeft()
  move.down(#building)

  -- return the total number of blocks placed
  return build_count

end
