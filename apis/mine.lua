-- set a limit to the amount of times the vein function can call itself
local recursion_limit = 250


-- mine a vertical shaft all the way to bedrock,
-- mining any ore veins along the way
function ore_shaft()
  local count = 0
  local depth = 0
  while dig.down() > 0 do
    depth = depth + 1
    count = count + ore_veins()
  end
  move.up(depth)
  return count
end


-- mine any blocks around that are ores
function ore_veins(level)

  -- a way to keep track of the recursion level, and not
  -- call ourselves if we're in deep
  level = opt.get(level, 1)

  local count = 0
  local moved = 0

  -- up
  -- checking up first should mean that we float first and
  -- encounter fewer recursion errors, probably
  while ore.up() do
    dig.up()
    count = count + 1
    moved = moved + 1
  end
  while moved > 0 do
    if level < recursion_limit then
      count = count + ore_veins(level + 1)
    end
    dig.down()
    moved = moved - 1
  end

  -- loop and look in all four directions
  for _ = 1, 4 do

    while ore.forward() do
      dig.forward()
      count = count + 1
      moved = moved + 1
    end
    while moved > 0 do
      if level < recursion_limit then
        count = count + ore_veins(level + 1)
      end
      -- this is attempting to solve the problem where a block becomes
      -- solid after a turtle has already mined through it,
      -- like cobblestone appearing where lava meets water
      if not turtle.back() then
        turtle.turnLeft()
        turtle.turnLeft()
        dig.forward()
        turtle.turnLeft()
        turtle.turnLeft()
      end
      moved = moved - 1
    end

    -- turn to check all directions
    turtle.turnLeft()

  end

  -- down
  -- this used to be done second but that means there is
  -- a risk of lots of ups and downs at the corners of
  -- the spheres. up-middle-down hopefully is sane
  while ore.down() do
    dig.down()
    count = count + 1
    moved = moved + 1
  end
  while moved > 0 do
    if level < recursion_limit then
      count = count + ore_veins(level + 1)
    end
    dig.up()
    moved = moved - 1
  end

  return count

end


-- mine all blocks that match the given block id
-- TODO: determine a fix for java exception error after
-- arbitrary limit of 256 recursion
-- error: java.lang.ArrayIndexOutOfBoundsException
function vein(block, level)

  -- throw an error if the block name is not passed
  if block == nil then error("Block is nil.") end

  -- a way to keep track of the recursion level, and not
  -- call ourselves if we're in deep
  level = opt.get(level, 1)

  local count = 0

  -- up
  -- checking up first should mean that we float first and
  -- encounter fewer recursion errors, probably
  if turtle.detectUp() and match.up(block) then
    dig.up()
    count = count + 1
    if level < recursion_limit then
      count = count + vein(block, level + 1)
    end
    turtle.down()
  end

  -- loop and look in all four directions
  for i=1,4 do

    -- seek forward so long as the blocks in front match
    local distance = 0
    while turtle.detect() and match.forward(block) do
      dig.forward()
      distance = distance + 1
    end

    -- append the total number of mined blocks
    count = count + distance

    -- move back and check for blocks while doing so
    while distance > 0 do
      if level < recursion_limit then
        count = count + vein(block, level + 1)
      end
      turtle.back()
      distance = distance - 1
    end

    -- turn to check all directions
    turtle.turnLeft()

  end

  -- down
  -- this used to be done second but that means there is
  -- a risk of lots of ups and downs at the corners of
  -- the spheres. up-middle-down hopefully is sane
  if turtle.detectDown() and match.down(block) then
    dig.down()
    count = count + 1
    if level < recursion_limit then
      count = count + vein(block, level + 1)
    end
    turtle.up()
  end

  return count

end
