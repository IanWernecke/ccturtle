-- api core logic
local dig_logic = function(detect, dig, move, num)

  num = opt.get(num, 1)

  -- attempt to dig and move the number of times requested (or one)
  local count = 0
  while count < num do

    -- allows blocks affected by gravity to be dug
    while detect() do
      if dig() then
        sleep(con.DIG_INTERVAL)
      else
        return count
      end
    end

    if not move() then return count end
    count = count + 1
  end
  return count

end


-- six basic directions
function back(num)
    turtle.turnLeft()
    turtle.turnLeft()
    return forward(num)
end
function down(num)
    return dig_logic(turtle.detectDown, turtle.digDown, turtle.down, num)
end
function forward(num)
    return dig_logic(turtle.detect, turtle.dig, turtle.forward, num)
end
function left(num)
    turtle.turnLeft()
    return forward(num)
end
function right(num)
    turtle.turnRight()
    return forward(num)
end
function up(num)
    return dig_logic(turtle.detectUp, turtle.digUp, turtle.up, num)
end
