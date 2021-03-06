-- fill/auto
-- description: attempt to fill the bottommost layer of a rectangular pit
-- requires: seek, inventory, place, move, fill


-- sink to the bottom of wherever the turtle is
local sank = seek.down()

-- get into a corner
seek.right()
seek.right()

-- calculate the width and length
local x = seek.right()
local y = seek.right()

-- ensure enough blocks exist to fill the area
if inventory.count() < x * y then
    error("Not enough blocks.")
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
            error("Out of blocks! Exiting ...")
        end

        -- fill under, if the bottom of the pit was missed
        if not turtle.detectDown() then
            fill.down()
        end

    end

    turtle.turnLeft()

end

turtle.up()
place.down()

-- try to move back to the starting level
if 0 < sank then
    move.up(sank - 1)
end
