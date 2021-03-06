-- fill/layer
-- description: attempt to fill the bottommost layer of a rectangular pit
-- requires: seek, inventory, place, move, fill


-- get into a corner
seek.right()
seek.right()

-- calculate the width and length
local x = seek.right()
local y = seek.right()

-- ensure enough blocks exist to fill the area
if inventory.count() < x * y then
    print("Not enough blocks.")
    return false
end

-- fill in the area
placed = true
while placed do

    placed = false
    while turtle.back() do

        -- attempt to place a block forwards
        if place.forward() then

            placed = true

        else

            -- turn around so if the program is run again,
            -- the double seek right will reorient correctly
            turtle.turnLeft()
            turtle.turnLeft()

            -- print that we are out of blocks and exit
            print("Out of blocks! Exiting ...")
            return false

        end

    end

    turtle.turnLeft()

end

turtle.up()
place.down()
