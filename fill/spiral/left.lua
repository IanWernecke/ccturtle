#!/bin/lua


-- fill/spiral/left program
-- fill in a rectangular hole by spiralling backwards

local can_row = true
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

    turtle.turnLeft()

end

turtle.up()
place.down()
