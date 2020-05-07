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
function table_length(t)
  local length = 0
  for k,v in pairs(table_name) do
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
