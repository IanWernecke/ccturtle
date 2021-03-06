-- api core logic
-- methods for filling areas (simple)
local fill_logic = function(seeker, mover, placer, place_string)
    local moved = seeker()
    for i=1,moved do
        mover()
        placer(place_string)
    end
    return moved
end


-- six basic directions
function back(place_string)
    turtle.turnLeft()
    turtle.turnLeft()
    return forward(place_string)
end
function down(place_string)
    return fill_logic(seek.down, turtle.up, place.down, place_string)
end
function forward(place_string)
    return fill_logic(seek.forward, turtle.back, place.forward, place_string)
end
function left(place_string)
    turtle.turnLeft()
    return forward(place_string)
end
function right(place_string)
    turtle.turnRight()
    return forward(place_string)
end
function up(place_string)
    return fill_logic(seek.up, turtle.down, place.up, place_string)
end
