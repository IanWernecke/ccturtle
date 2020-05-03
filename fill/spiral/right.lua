#!/bin/lua


-- fill/spiral/right program
-- fill in a rectangular hole by spiralling backwards

can_row = true
while can_row do

    can_row = false

    -- fill the entire row
    while turtle.back() do
        can_row = true
        if not place.forward() then
            print('Out of blocks! Exiting ...')
            return false
        end
    end

    turtle.turnRight()

end

turtle.up()
place.down()
