-- api core logic
local clear_logic = function(detect, dig)

  -- if nothing is there, return success
  if not detect() then return 1 end

  -- something is there, return whether we can dig it
  return dig() and true or false

end


function back()
    turtle.turnLeft()
    turtle.turnLeft()
    return forward()
end
function down()
    return clear_logic(turtle.detectDown, turtle.digDown)
end
function forward()
    return clear_logic(turtle.detect, turtle.dig)
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
    return clear_logic(turtle.detectUp, turtle.digUp)
end


-- section for the logic and call functions of spirals
local spiral = function(turn_command)
    local i = 0
    while turtle.detect() do
        while turtle.detect() do
            turtle.dig()
            turtle.forward()
            i = i + 1
        end
        turn_command()
    end
    return i
end

function spiral_left()
    return spiral(turtle.turnLeft)
end
function spiral_right()
    return spiral(turtle.turnRight)
end


-- custom tunnel, 4 high, num long
function tunnel( num )

    local movements = { turtle.up, turtle.down }
    local i = 0
    while i < num do

        local j = 0
        local movement = movements[ (i%2)+1 ]
        while j < 3 do
            forward()
            movement()
            j = j + 1
        end
        forward()

        i = i + 1

        -- settle
        if i == num then
            -- odd amount of movements
            if i%2 == 1 then
                    move.down( 3 )
            end

        -- move forward a step
        else
            move.forward()
        end
    end

end
