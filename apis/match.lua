-- api core logic
-- logic to match the block using inspection
local match_logic = function(string_id, action)
    local success, data = action()
    return success and data.name and string_id == data.name or false
end


-- series of commands to test strings against connected blocks
function back(string_id)
    turtle.turnLeft()
    turtle.turnLeft()
    return forward(string_id)
end
function forward(string_id)
    return match_logic(string_id, turtle.inspect)
end
function down(string_id)
    return match_logic(string_id, turtle.inspectDown)
end
function left(string_id)
    turtle.turnLeft()
    return forward(string_id)
end
function right(string_id)
    turtle.turnRight()
    return forward(string_id)
end
function up(string_id)
    return match_logic(string_id, turtle.inspectUp)
end