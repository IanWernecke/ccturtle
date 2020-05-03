-- a simple function for getting a value or a default value if the argument is nil
-- examples:
--  > $command a b
--    local args = {...}
--    arg.get(args, 1, "x") --> "a"
--    arg.get(args, 2, "x") --> "b"
--    arg.get(args, 3, "x") --> "x"
--    arg.get(args, 100, "x") --> "x"
--    arg.get(args, 100) --> nil
function get(arg_table, arg_index, default)
  return (#arg_table >= arg_index and arg_table[arg_index] or default)
end

function get_number(arg_table, arg_index, default)
  return tonumber(get(arg_table, arg_index, default))
end
