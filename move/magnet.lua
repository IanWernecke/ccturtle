-- move/magnet.lua

while turtle.detectDown() and not turtle.detect() do
	turtle.forward()
end

if not turtle.detectDown() then
	turtle.back()
end
