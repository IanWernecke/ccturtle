mine.ore_shaft()

-- top the shaft with a bit of cobblestone if possible
if inventory.contains(con.BLOCK_COBBLESTONE) then
  place.down(con.BLOCK_COBBLESTONE)
end
