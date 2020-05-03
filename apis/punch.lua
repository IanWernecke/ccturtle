-- punch logic
-- param: detector
local punch_logic = function(detector, digger, matcher, mover, block)

    local i = 0
    if block == nil then
        -- block was not given, punch through everything
        while detector() do
            digger()
            i = i + 1
        end
    else
        -- if a block was given, only punch through blocks that match
        while detector() and matcher(block) do
            digger()
            i = i + 1
        end
    end
    mover(i)
    return i

end


-- file: apis/punch
-- set of functions for boring and returning
-- these functions do not follow the normal schema
-- because they revert their turns to their original
-- orientation
function back(block)
    turtle.turnLeft()
    turtle.turnLeft()
    local result = forward(block)
    turtle.turnLeft()
    turtle.turnLeft()
    return result
end
function down(block)
    return punch_logic(
        turtle.detectDown,
        dig.down,
        match.down,
        move.up,
        block
    )
end
function forward(block)
    return punch_logic(
        turtle.detect,
        dig.forward,
        match.forward,
        move.back,
        block
    )
end
function left(block)
    turtle.turnLeft()
    local result = forward(block)
    turtle.turnRight()
    return result
end
function right(block)
    turtle.turnRight()
    local result = forward(block)
    turtle.turnLeft()
    return result
end
function up(block)
    return punch_logic(
        turtle.detectUp,
        dig.up,
        match.up,
        move.down,
        block
    )
end
