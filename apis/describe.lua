-- api core logic
local describe_logic = function(action)
    local success, data = action()
    if success then
        print("Block name: " .. data.name)
    end
end


-- standard six functions for directional commands
function back()
    turtle.turnLeft()
    turtle.turnLeft()
    return forward()
end
function forward()
    return describe_logic(turtle.inspect)
end
function down()
    return describe_logic(turtle.inspectDown)
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
    return describe_logic(turtle.inspectUp)
end
