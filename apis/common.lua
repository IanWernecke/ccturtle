--
--  /apis/common.lua
--
--  description:
--    this file is built to house functions that manipulate lua objects and
--    perform generic tasks easier in other languages
--


-- obtain a string from the command line, or the default value given if not present
-- return: string
--
-- examples:
--  > $command a b
--    local args = {...}
--    common.arg_get(1, "x") --> "a"
--    common.arg_get(args, 2, "x") --> "b"
--    common.arg_get(args, 3, "x") --> "x"
--    common.arg_get(args, 100, "x") --> "x"
--    common.arg_get(args, 100) --> nil
function arg_get(index, default)
  table_get(arg, index, default)
end


-- obtain a number from the command line, or the default if a value is not present
-- return: number
function arg_get_number(index, default)
  return tonumber(arg_get(index, default))
end


-- create a copy of a given table for modification
-- return: table
function table_copy(table)
  local result = {}
  for k,v in pairs(table) do
    result[k] = v
  end
  return result
end


-- determine whether the two tables are identical
-- return: (boolean)
function tables_equal(first_table, second_table)
  return table_length(first_table) == table_length(second_table) and table_match(first_table, second_table)
end


-- obtain a value if it exists in the given table, or return the default value given
function table_get(table, index, default)
  for i,v in ipairs(table) do
    if index == i then
      return v
    end
  end
  return default
end


-- obtain the number of keys in a table
-- return: number
function table_length(table)
  local length = 0
  for k,v in pairs(table) do
    length = length + 1
  end
  return length
end


-- determine whether the first table given is a subset of the second table
-- return: (boolean)
function table_match(sub_table, super_table)
  for key, value in pairs(sub_table) do
    if not super_table[key] or value ~= super_table[key] then
      return false
    end
  end
  return true
end


-- print a table for visibility
function table_format(table, prefix)

  -- default the prefix to an empty string
  prefix = opt_get(prefix, "")
  local prefix_during = prefix .. "  "
  local result = "{\n"
  local key_fmt = nil
  local value_fmt = nil

  -- for each key and value in the table
  for key, value in pairs(table) do

    -- determine the key format string
    if type(key) == "string" then
      key_fmt = '"%s"'
    elseif type(key) == "number" then
      key_fmt = "%d"
    else
      error(string.format("Unhandled value type: %s", type(key)))
    end

    -- if the value type is table
    if type(value) == "table" then
      result = result .. string.format(prefix_during .. key_fmt .. ": %s", key, table_format(value, prefix_during))
    else

      -- if the value type is anything other than table
      if type(value) == "string" then
        value_fmt = '"%s"'
      elseif type(value) == "number" then
        value_fmt = "%d"
      else
        error(string.format("Unhandled value type: %s", type(value)))
      end
      result = result .. string.format(prefix_during .. key_fmt .. ": " .. value_fmt .. "\n", key, value)

    end

  end
  result = result .. prefix .. "}\n"
  return result

end


-- print out the string representation of a table
-- return: nil
function table_print(message, table)

  print(string.format("%s: %s", message, table_format(table)))

end


-- global function assignments
_G.arg_get = arg_get
_G.arg_getn = arg_get_number
_G.copy = table_copy
_G.detail = turtle.getItemDetail
_G.get = table_get
_G.getc = function(data, index) return data:sub(index, index) end
_G.opt_get = function(value, default) return (value == nil and default or value) end
_G.teq = tables_equal
