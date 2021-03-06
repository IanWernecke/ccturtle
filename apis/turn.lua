-- turn around
function back()
  return (left(2) == 2 and true or false)
end


-- turn left the specified number of times (default: 1)
function left(num)
  num = opt.get(num, 1)
  for count = 1, num do
    turtle.turnLeft()
  end
  return num
end


-- turn right the specified number of times (default: 1)
function right(num)
  num = opt.get(num, 1)
  for count = 1, num do
    turtle.turnRight()
  end
  return num
end
