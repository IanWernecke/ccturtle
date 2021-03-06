-- file:
--   /apis/cleft
--
-- description:
--   a collection of functions for removing strips of land
--   in particular, removing in a direction and all
--   blocks above them
--
-- requires:
--   detect, dig, punch


-- four primary directions, since cleft always digs up,
-- there is no reason for an up/down
function back()
    turtle.turnLeft()
    turtle.turnLeft()
    return forward()
end
function forward()
    local moved = 0
    while detect.forward() do
        dig.forward()
        punch.up()
        moved = moved + 1
    end
    return moved
end
function left()
    turtle.turnLeft()
    return forward()
end
function right()
    turtle.turnRight()
    return forward()
end
