-- api core logic
local slide_logic = function(detection, movement)
    local i = 0
    while detection() do
        if not movement() then
            return i
        end
        i = i + 1
    end
    return i
end


-- standard six directional commands
function back()
    local i = slide_logic(turtle.detectDown, turtle.back)
    return i
end
function down()
    return slide_logic(turtle.detect, turtle.down)
end
function forward()
    return slide_logic(turtle.detectDown, turtle.forward)
end
function left()
    turtle.turnLeft()
    return forward(num)
end
function right()
    turtle.turnRight()
    return forward(num)
end
function up()
    return slide_logic(turtle.detect, turtle.up)
end
