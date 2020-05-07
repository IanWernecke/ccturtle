--
--  /apis/common.lua
--
--  description:
--    this file is built to house functions that manipulate lua objects and
--    perform generic tasks easier in other languages
--


-- determine whether the two tables are identical
-- return: (boolean)
function tables_equal(first_table, second_table)
  return table_length(first_table) == table_length(second_table) and table_match(first_table, second_table)
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
function table_print(table)
  for key, value in pairs(table) do

    -- determine the key format string
    if type(key) == "string" then
      key_fmt = '"%s"'
    elseif type(key) == "number" then
      key_fmt = "%d"
    else
      error(string.format("Unhandled value type: %s", type(key)))
    end

    -- determine the value format string
    if type(value) == "string" then
      value_fmt = '"%s"'
    elseif type(value) == "number" then
      value_fmt = "%d"
    else
      error(string.format("Unhandled value type: %s", type(value)))
    end

    -- print the string that will display our values
    print(string.format("  " .. key_fmt .. ":" .. value_fmt, key, value))

  end
end
