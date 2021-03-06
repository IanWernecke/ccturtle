#!/bin/lua

-- walls program


-- function: wall
-- fill below, build 3 high, and come back down
function wall()
  fill.down()
  for height = 1, 4 do
    turtle.up()
    place.down()
  end
  move.back()
  seek.down()
end


-- function: seek_around
-- return: whether a new spot to build a wall was found nearby
function seek_around()

  turtle.turnRight()

  -- bottom right
  if detect.forward() then return false end
  turtle.forward()
  if not detect.down() then return true end

  turtle.turnLeft()

  -- right mid
  if detect.forward() then return false end
  turtle.forward()
  if not detect.down() then return true end

  -- top right
  if detect.forward() then return false end
  turtle.forward()
  if not detect.down() then return true end

  turtle.turnLeft()

  -- top mid
  if detect.forward() then return false end
  turtle.forward()
  if not detect.down() then return true end

  -- top left
  if detect.forward() then return false end
  turtle.forward()
  if not detect.down() then return true end

  turtle.turnLeft()

  -- left mid
  if detect.forward() then return false end
  turtle.forward()
  if not detect.down() then return true end

end


-- ensure building material
if not inventory.count() then
  error("Out of supplies!")
end


-- initialize towards the edge of the walkway
slide.forward()
wall()


-- the primary loop to continue building the walls
while seek_around() do
  wall()

  -- ensure building material
  if not inventory.count() then
    error("Out of supplies.")
  end

end
