-- program:
--   clear/shelf/right
-- description:
--   clear a shelf on a hillside by removing
--   blocks to the front, the right, and upwards
-- requires:
--   cleft, detect, dig, move, punch

local turn_to = turtle.turnRight
local turn_back = turtle.turnLeft

-- while blocks are in front, clear them out
while detect.forward() do

    -- move forward and remove above
    dig.forward()
    punch.up()

    -- ensure the side is cleared
    turn_to()
    move.back(cleft.forward())
    turn_back()

end
