-- file:
--      /fill/gap
-- description:
--      fill a gap with blocks
-- requires:
--      detect, fill, move

-- move forward if we are at the edge
if detect.down() then
    move.forward()
end

-- while no block detect underneath,
-- fill under and move forward
while not detect.down() do
    fill.down()
    if not move.forward() then
        exit(1)
    end
end
