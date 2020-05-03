-- api constants
DIG_INTERVAL = 0.5


-- mod prefixes for block and item details
MOD_APPLIED_ENERGISTICS = "appliedenergistics2"
MOD_CHISEL = "chisel"
MOD_INDUSTRIAL_CRAFT = "ic2"
MOD_MINECRAFT = "minecraft"
MOD_NETHER_ORES = "NetherOres"
MOD_THERMAL_FOUNDATION = "thermalfoundation"


-- block details are obtained via:
--  turtle.inspect() or turtle.inspectUp() or turtle.inspectDown()
BLOCK_ANDESITE = {name=MOD_CHISEL .. ":andesite"}
BLOCK_CHEST = {name=MOD_MINECRAFT .. ":chest"}
BLOCK_COAL = {name=MOD_MINECRAFT .. ":coal_ore"}
BLOCK_COBBLESTONE = {name=MOD_MINECRAFT .. ":cobblestone"}
BLOCK_DIRT = {name=MOD_MINECRAFT .. ":dirt"}
BLOCK_GRASS = {name=MOD_MINECRAFT .. ":grass"}
BLOCK_MARBLE = {name=MOD_CHISEL .. ":marble"}
BLOCK_NETHER_GOLD = {name=MOD_NETHER_ORES .. ":tile.netherores.ore.0"}
BLOCK_PLANKS = {name=MOD_MINECRAFT .. ":planks"}
BLOCK_SKYSTONE = {name=MOD_APPLIED_ENERGISTICS .. ":sky_stone_block"}
BLOCK_STONE = {name=MOD_MINECRAFT .. ":stone"}
BLOCK_STONEBRICK = {name=MOD_MINECRAFT .. ":stonebrick"}


-- item details are obtained via:
--  turtle.getItemDetails(slot)
ITEM_CUTTER = {name=MOD_INDUSTRIAL_CRAFT .. ":cutter"}
ITEM_COPPER_CABLE = {name=MOD_INDUSTRIAL_CRAFT .. ":cable", damage=0}
ITEM_COPPER_INGOT = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=128}
ITEM_COPPER_PLATE = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=320}
ITEM_FORGE_HAMMER = {name=MOD_INDUSTRIAL_CRAFT .. ":forge_hammer"}
ITEM_IRON_INGOT = {name=MOD_MINECRAFT .. ":iron_ingot"}
ITEM_IRON_PLATE = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=32}
ITEM_LOG = {name=MOD_MINECRAFT .. ":log"}
ITEM_PLANKS = {name=BLOCK_PLANKS}
ITEM_STICK = {name=MOD_MINECRAFT .. ":stick"}


-- recipes
--  these should only use ITEM_* constants, for consistency
RECIPE_COPPER_PLATE = {{"hi"}, {h=ITEM_FORGE_HAMMER, i=ITEM_COPPER_INGOT}}
RECIPE_COPPER_WIRE = {{"cp"}, {c=ITEM_CUTTER, p=ITEM_COPPER_PLATE}}
RECIPE_CUTTER = {{"p.p", ".p", "i.i"}, {p=ITEM_IRON_PLATE, i=ITEM_IRON_INGOT}}
RECIPE_FORGE_HAMMER = {{"ii", "iss", "ii"}, {i=ITEM_IRON_INGOT, s=ITEM_STICK}}
RECIPE_PLANKS = {{"w"}, {w=ITEM_LOG}}
RECIPE_STICK = {{"p", "p"}, {p=ITEM_PLANKS}}


-- recipe map
--  for creating items required for other recipes
RECIPES = {
  ITEM_COPPER_PLATE=RECIPE_COPPER_PLATE,
  ITEM_COPPER_WIRE=RECIPE_COPPER_WIRE,
  ITEM_CUTTER=RECIPE_CUTTER,
  ITEM_FORGE_HAMMER=RECIPE_FORGE_HAMMER,
  ITEM_PLANKS=RECIPE_PLANKS,
  ITEM_STICK=RECIPE_STICK
}
