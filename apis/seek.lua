-- program apis/seek
-- logic and controlling for seek segment
local seek_logic = function(detection, movement)
    local i = 0
    while not detection() do
        movement()
        i = i + 1
    end
    return i
end


-- six standard directions
function back()
    local i = 0
    while turtle.back() do
        i = i + 1
    end
    return i
end
function forward()
    return seek_logic(turtle.detect, turtle.forward)
end
function down()
    return seek_logic(turtle.detectDown, turtle.down)
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
    return seek_logic(turtle.detectUp, turtle.up)
end
