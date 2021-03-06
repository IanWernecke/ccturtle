#!/bin/lua

-- api core logic
local basic_logic = function(detect, dig, move, num)
    local i = 0
    while i < num do
        if detect() then
            dig()
        end
        if move() then
            i = i + 1
        else
            return i
        end
    end
    return i
end


-- standard six directional commands
function back(num)
    turtle.turnLeft()
    turtle.turnLeft()
    return forward(num)
end
function down(num)
   return basic_logic(turtle.digDown, num)
end
function forward(num)
    return basic_logic(turtle.dig, num)
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
    return basic_logic(turtle.digUp, num)
end
