
-- program: mine/shafts
--  requires: dig, mine, turn

-- print the usage and exit
local usage = function()
  print("Usage: [SHAFTS=5]")
  error()
end


-- collect the arguments from the command line
local args = {...}

-- check the number of arguments
if #args > 1 then
  usage()
end


-- set the global values
SHAFTS = (#args > 0 and tonumber(args[1]) or 5)


-- given the current x, y coordinates, find the next shaft position
-- so the bots can see every visible blocks from their shafts
function find_next_shaft_position(x, y)

  local new_x, new_y = x, 0
  new_x = new_x + 1
  while (new_x + (new_y * 2)) % 5 ~= 0 do
    new_y = new_y + 1
  end
  return new_x, new_y

end


local shaft_count, x, y = 0, 0, 0
while shaft_count < SHAFTS do

  -- move forward and right the x amounts
  dig.forward(x)
  dig.right(y)

  -- if the shaft has already been dug, find next
  while match.down(con.BLOCK_COBBLESTONE) do
    local next_x, next_y = find_next_shaft_position(x, y)
    dig.left()
    if next_y > y then
      dig.right(next_y - y)
    else
      dig.left(y - next_y)
      turn.back()
    end
    x, y = next_x, next_y
  end

  -- mine the ore shaft and record it
  mine.ore_shaft()
  shaft_count = shaft_count + 1

  -- place a cobblestone down if possible
  if inventory.contains(con.BLOCK_COBBLESTONE) then
    place.down(con.BLOCK_COBBLESTONE)
  end

  -- return to the starting position to dump goods
  dig.back(y)
  dig.left(x)

  -- dump goods and prepare to begin again
  inventory.drop()
  turn.back()

  -- find the next coordinates in case there are more shafts to be dug
  x, y = find_next_shaft_position(x, y)

end
