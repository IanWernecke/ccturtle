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
function table_format(table, prefix)

  -- if the prefix was given, increase the prefix by 2 spaces
  if prefix == nil then
    prefix = "  "
  else
    prefix = prefix .. "  "
  end

  result = "{\n"

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
    if type(value) == "table"
      result = result + string.format(prefix .. key_fmt .. ": %s", key, table_format(value, prefix))
    else

      -- if the value type is anything other than table
      if type(value) == "string" then
        value_fmt = '"%s"'
      elseif type(value) == "number" then
        value_fmt = "%d"
      else
        error(string.format("Unhandled value type: %s", type(value)))
      end
      result = result + string.format(prefix .. key_fmt .. ":" .. value_fmt .. "\n", key, value)

    end

  end
  result = result .. prefix .. "}"
  return result

end


-- print out the string representation of a table
-- return: nil
function table_print(table)

  print(table_format(table))

end
