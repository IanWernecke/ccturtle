-- mine/stairs/down program


local usage = function()
  print("Usage: LAYERS [WIDTH=1] [HEIGHT=5]")
  error()
end


-- collect the arguments from the command line
local args = {...}


-- check the number of arguments
if #args == 0 or #args > 3 then
  usage()
end


-- set the global values for the staircase
SC_LAYERS = (#args > 0 and tonumber(args[1]) or 1)
SC_WIDTH = (#args > 1 and tonumber(args[2]) or 1)
SC_HEIGHT = (#args > 2 and tonumber(args[3]) or 5)


-- clear blocks above so long as there is something there
function clear_above(num)
  local count = 0
  while count < num and detect.up() do
    count = count + dig.up()
  done
  dig.down(count)
  return count
end


function dig_and_clear()

  dig.forward()

  -- ensure there is something to walk on
  if not detect.down() then place.down()

  -- clear spaces above the current block
  clear_above(SC_HEIGHT - 1)

end


-- dig a section of rock
function dig_stair_level()

  -- dig upwards and then forwards
  dig.up()
  dig_and_clear()

  -- if the width is greater than one, clear area to the right
  if SC_WIDTH > 1 then
    turn.right()
    for width = 1, SC_WIDTH - 1 do
      dig_and_clear()
    end
    dig.back(SC_WIDTH - 1)
    turn.right()
  end

end


-- dig each layer
for _ = 1, SC_LAYERS do
  dig_stair_level()
end
