-- standard six directional commands
function back()
    turtle.turnLeft()
    turtle.turnLeft()
    return forward()
end
function down()
    return turtle.detectDown()
end
function forward()
    return turtle.detect()
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
    return turtle.detectUp()
end
