function craft(recipe, num)

  -- ensure a chest is in front of the turtle
  if not match.forward(con.BLOCK_CHEST) then
    error("Chest not forward of turtle.")
  end

  -- get the number of times to craft the recipe
  num = opt.get(num, 1)

  -- suck up as many of the objects from the chest as possible
  while turtle.suck() do end

  -- ensure we have enough supplies to craft the required item
  local layout = #recipe[1]
  local resources = #recipe[2]

  -- for each row and column in the layout
  for row_index = 1, #layout do
    local row = layout[row_index]
    for column_index = 1, #row do

      -- only try to move a resource to this location if it is non-empty
      local char = row.sub(column_index, column_index)
      if char ~= "." then

        -- find the source and destination slots of various items
        local dst = (row_index * 4) + column_index
        local src = inventory.find(resources[char])
        if src == nil then
          error("Failed to find resource: " .. resources[char])
        end

        -- empty the destination slot and then move the items there
        inventory.empty(dst)
        inventory.move(src, dst)

      end

    end
  end

  return turtle.craft()

end
