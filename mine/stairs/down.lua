-- mine/stairs/down program
-- requires: detect, dig, place, turn

local usage = function()
  print("Usage: DEPTH [WIDTH=1] [HEIGHT=5]")
  error()
end


-- collect the arguments from the command line
local args = {...}


-- check the number of arguments
if #args == 0 or #args > 3 then
  usage()
end


-- set the global values for the staircase
SC_DEPTH = (#args > 0 and tonumber(args[1]) or 1)
SC_WIDTH = (#args > 1 and tonumber(args[2]) or 1)
SC_HEIGHT = (#args > 2 and tonumber(args[3]) or 5)


-- dig a section of rock
function dig_stair_level()

  -- ensure there is a layer to walk on
  if not detect.down() then place.down() end

  -- init locals and begin work
  local count = 0
  local res = dig.back(dig.forward(SC_HEIGHT - 1))
  count = count + res

  -- if unable to dig the entire row, turn left to face forward at least
  if res ~= SC_HEIGHT - 1 then
    turn.back()
    return count
  end

  -- face right before determining whether to dig more rows
  turn.left()

  -- if there is a width to be dug
  if SC_WIDTH > 1 then
    for width = 2, SC_WIDTH do

      -- ensure we can dig forward 1
      res = dig.forward()
      if res ~= 1 then
        turn.left()
        return count
      end
      count = count + 1

      -- ensure there is a layer to walk on
      if not detect.down() then place.down() end

      -- ensure we can dig left 6
      res = dig.back(dig.left(SC_HEIGHT - 1))
      count = count + res
      if res ~= SC_HEIGHT - 1 then
        turn.back()
        return count
      end

      turn.left()

    end

    -- return to the starting row
    -- (position before width > 1 movement)
    dig.back(SC_WIDTH - 1)
    turn.right()

  else
    turn.left()
  end

  return count

end


-- keep track of the total amount dug
local count = 0
local level_expect = (SC_HEIGHT * SC_WIDTH) - 1
for depth = 1, SC_DEPTH do

  -- ensure we can dig forwards and down
  if dig.forward() == 0 or dig.down() == 0 then
    dig.back()
    turn.back()
    error("Failed to progress to next level of staircase.")
  end

  -- increment the count for the down layer movement
  count = count + 1

  local res = dig_stair_level()
  count = count + res
  if res ~= level_expect then
    error(string.format("Failed to completely dig level! [%d/%d]", res, level_expect))
  end

end
print(string.format('Dug %d blocks!', count))
