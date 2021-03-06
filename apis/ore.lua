-- old: "[^\w][Oo]re$"
-- "bigreactors:oreyellorite" (KO)
-- "mekanism:oreblock" (KO)
-- "mysticalagriculture:prosperity_ore" (KO)
-- "thermalfoundation:ore" (OK)
local ORE_NAME_REGEX = "[^\w][Oo]re"


-- api core logic
-- logic to match the block using inspection
local is_ore_logic = function(inspect_action)
    local success, data = inspect_action()
    if success then
        return string.match(data.name, ORE_NAME_REGEX) ~= nil or (
          data.state and data.state.type and string.match(data.state.type, ORE_NAME_REGEX)
        ) ~= nil
    else
        return false
    end
end


-- series of commands to inspect nearby blocks against the ore regex
function back()
    turtle.turnLeft()
    turtle.turnLeft()
    return forward()
end
function forward()
    return is_ore_logic(turtle.inspect)
end
function down()
    return is_ore_logic(turtle.inspectDown)
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
    return is_ore_logic(turtle.inspectUp)
end
