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


-- items: minecraft items
ITEM_COBBLESTONE = {name=MOD_MINECRAFT .. ":cobblestone"}
ITEM_FURNACE = {name=MOD_MINECRAFT .. ":furnace"}
ITEM_IRON_INGOT = {name=MOD_MINECRAFT .. ":iron_ingot"}
ITEM_LOG = {name=MOD_MINECRAFT .. ":log"}
ITEM_PLANKS = {name=MOD_MINECRAFT .. ":planks"}
ITEM_REDSTONE = {name=MOD_MINECRAFT .. ":redstone"}
ITEM_STICK = {name=MOD_MINECRAFT .. ":stick"}


-- items: industrial craft items
ITEM_BATTERY = {name=MOD_INDUSTRIAL_CRAFT .. ":re_battery"}
ITEM_COPPER_CABLE = {name=MOD_INDUSTRIAL_CRAFT .. ":cable", damage=0}
ITEM_CUTTER = {name=MOD_INDUSTRIAL_CRAFT .. ":cutter"}
ITEM_FORGE_HAMMER = {name=MOD_INDUSTRIAL_CRAFT .. ":forge_hammer"}
ITEM_INSULATED_COPPER_CABLE = {name=MOD_INDUSTRIAL_CRAFT .. ":cable", damage=0}
ITEM_INSULATED_TIN_CABLE = {name=MOD_INDUSTRIAL_CRAFT .. ":cable", damage=4}
ITEM_IRON_FURNACE = {name=MOD_INDUSTRIAL_CRAFT .. ":te", damage=46}
ITEM_RUBBER = {name=MOD_INDUSTRIAL_CRAFT .. ":crafting", damage=0}
ITEM_TIN_CASING = {name=MOD_INDUSTRIAL_CRAFT .. ":casing", damage=6}


-- items: thermal foundation
ITEM_COPPER_INGOT = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=128}
ITEM_COPPER_PLATE = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=320}
ITEM_IRON_PLATE = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=32}
ITEM_PULVERIZED_COAL={name=MOD_THERMAL_FOUNDATION .. ":material", damage=768}
ITEM_TIN_INGOT = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=129}
ITEM_TIN_PLATE = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=321}


-- recipes
--  these should only use ITEM_* constants, for consistency


-- recipes: minecraft recipes
RECIPE_FURNACE = {{"ccc", "c.c", "ccc"}, {c=ITEM_COBBLESTONE}}
RECIPE_PLANKS = {{"w"}, {w=ITEM_LOG}}
RECIPE_STICK = {{"p", "p"}, {p=ITEM_PLANKS}}


-- recipes: industrial craft recipes
--  note: cables cannot be automatically crafted at this time because of how getItemDetail() does not
--    manage to return enough information about items
RECIPE_BATTERY = {{".w", "crc", "crc"}, {w=ITEM_INSULATED_TIN_CABLE, c=ITEM_TIN_CASING, r=ITEM_REDSTONE}}
RECIPE_COPPER_CABLE = {{"cp"}, {c=ITEM_CUTTER, p=ITEM_COPPER_PLATE}}
RECIPE_CIRCUIT = {{"ccc", "rpr", "ccc"}, {c=ITEM_INSULATED_COPPER_CABLE, r=ITEM_REDSTONE, p=ITEM_IRON_PLATE}}
RECIPE_CUTTER = {{"p.p", ".p", "i.i"}, {p=ITEM_IRON_PLATE, i=ITEM_IRON_INGOT}}
RECIPE_FORGE_HAMMER = {{"ii", "iss", "ii"}, {i=ITEM_IRON_INGOT, s=ITEM_STICK}}
RECIPE_GENERATOR = {{".b", "ppp", ".f"}, {b=ITEM_BATTERY, p=ITEM_IRON_PLATE, f=ITEM_IRON_FURNACE}}
-- RECIPE_INSULATED_COPPER_CABLE = {{"rw"}, {r=ITEM_RUBBER, w=ITEM_COPPER_CABLE}}
RECIPE_IRON_FURNACE = {{".p", "p.p", "pfp"}, {p=ITEM_IRON_PLATE, f=ITEM_FURNACE}}


-- recipes: thermal foundation
RECIPE_COPPER_PLATE = {{"hi"}, {h=ITEM_FORGE_HAMMER, i=ITEM_COPPER_INGOT}}
RECIPE_IRON_PLATE = {{"hi"}, {h=ITEM_FORGE_HAMMER, i=ITEM_IRON_INGOT}}
RECIPE_TIN_CASING = {{"hp"}, {h=ITEM_FORGE_HAMMER, p=ITEM_TIN_PLATE}}
RECIPE_TIN_PLATE = {{"hi"}, {h=ITEM_FORGE_HAMMER, i=ITEM_TIN_INGOT}}


-- recipe map
--  for creating items required for other recipes
-- WARNING: the keys here are strings because of how lua handles key assignment
RECIPES = {

  -- minecraft item recipes
  ITEM_FURNACE=RECIPE_FURNACE,
  ITEM_PLANKS=RECIPE_PLANKS,
  ITEM_STICK=RECIPE_STICK,

  -- industrial craft item recipes
  ITEM_BATTERY=RECIPE_BATTERY,
  ITEM_COPPER_CABLE=RECIPE_COPPER_CABLE,
  ITEM_CUTTER=RECIPE_CUTTER,
  ITEM_FORGE_HAMMER=RECIPE_FORGE_HAMMER,
  ITEM_INSULATED_COPPER_CABLE=RECIPE_INSULATED_COPPER_CABLE,
  ITEM_IRON_FURNACE=RECIPE_IRON_FURNACE,

  -- thermal foundation
  ITEM_COPPER_PLATE=RECIPE_COPPER_PLATE,
  ITEM_IRON_PLATE=RECIPE_IRON_PLATE,
  ITEM_TIN_CASING=RECIPE_TIN_CASING,
  ITEM_TIN_PLATE=RECIPE_TIN_PLATE

}
