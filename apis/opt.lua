-- a simple function for getting a value or a default value if the argument is nil
-- examples:
--  get(nil, 4) --> 4
--  get(3, 4) --> 3
--  get(3, nil) --> 3
--  get(nil, nil) --> nil
function get(possible, default)
  return (possible == nil and default or possible)
end
