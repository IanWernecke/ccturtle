-- program apis/move
-- logic and controlling for movement segment
local move_logic = function(movement, num)

    num = opt.get(num, 1)

    -- perform the movements
    for i = 1, num do
        if not movement() then return i end
    end
    return num

end


-- six standard directions
--
-- note: back uses turtle.back() instead of turning,
--      which is against traditional schema
--
function back(num)

    -- null argument fixer
    num = opt.get(num, 1)

    local count = 0
    for i = 1, num do
        turtle.back()
        count = count + 1
    end
    return count

end
function down(num)
    return move_logic(turtle.down, num)
end
function forward(num)
    return move_logic(turtle.forward, num)
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
    return move_logic(turtle.up, num)
end


-- special functions
function magnet()
    while turtle.detectDown() and not turtle.detect() do
        turtle.forward()
    end
    if not turtle.detectDown() then
        turtle.back()
    end
end
