#!/bin/lua


-- api core logic
local bore_logic = function(detect, action, movement)
    local i = 0
    while detect() do
        action()
        movement()
        i = i + 1
    end
    return i
end


-- six standard directional commands
function back()
    turtle.turnLeft()
    turtle.turnLeft()
    return forward()
end
function forward()
    return bore_logic(turtle.detect, turtle.dig, turtle.forward)
end
function down()
    return bore_logic(turtle.detectDown, turtle.digDown, turtle.down)
end
function left()
    turtle.turnLeft()
    return forward()
end
function right()
    turtle.turnRight()
    return forward()
end
function up()
    return bore_logic(turtle.detectUp, turtle.digUp, turtle.up)
end
