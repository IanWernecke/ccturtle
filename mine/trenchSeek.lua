-- trenchSeek program
-- dig a trench until a block is hit

while not turtle.detect() do

	if turtle.detectDown() then
		turtle.digDown()
	end
	turtle.forward()

end

