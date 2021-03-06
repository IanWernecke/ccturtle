-- api constants
DIG_INTERVAL = 0.5


-- mod prefixes for block and item details
MOD_APPLIED_ENERGISTICS = "appliedenergistics2"
MOD_BUILDCRAFT_BUILDERS = "buildcraftbuilders"
MOD_BUILDCRAFT_CORE = "buildcraftcore"
MOD_BUILDCRAFT_TRANSPORT = "buildcrafttransport"
MOD_CHISEL = "chisel"
MOD_ENERGY_CONVERTERS = 'energyconverters'
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
ITEM_DIAMOND = {name=MOD_MINECRAFT .. ":diamond"}
ITEM_DIAMOND_PICKAXE = {name=MOD_MINECRAFT .. ":diamond_pickaxe"}
ITEM_FURNACE = {name=MOD_MINECRAFT .. ":furnace"}
ITEM_GLASS = {name=MOD_MINECRAFT .. ":glass"}
ITEM_GOLD_INGOT = {name=MOD_MINECRAFT .. ":gold_ingot"}
ITEM_IRON_INGOT = {name=MOD_MINECRAFT .. ":iron_ingot"}
ITEM_LOG = {name=MOD_MINECRAFT .. ":log"}
ITEM_PISTON = {name=MOD_MINECRAFT .. ":piston"}
ITEM_PLANKS = {name=MOD_MINECRAFT .. ":planks"}
ITEM_REDSTONE = {name=MOD_MINECRAFT .. ":redstone"}
ITEM_STICK = {name=MOD_MINECRAFT .. ":stick"}
ITEM_STONE = {name=MOD_MINECRAFT .. ":stone"}


-- items: buildcraft/buildcraftbuilders
ITEM_QUARRY = {name=MOD_BUILDCRAFT_BUILDERS .. ":quarry"} -- damage=0
ITEM_STIRLING_ENGINE = {name=MOD_BUILDCRAFT_CORE .. ":engine", damage=1}
ITEM_WOODEN_PIPE = {name=MOD_BUILDCRAFT_TRANSPORT .. ":pipe_wood_item", damage=0} -- damage=0; unconfirmed


-- items: energy converters
ITEM_ENERGY_BRIDGE = {name=MOD_ENERGY_CONVERTERS .. ":energy_bridge"} -- damage=0
ITEM_ENERGY_CONSUMER_EU_LV = {name=MOD_ENERGY_CONVERTERS .. ":energy_consumer_eu", damage=0} -- damage=4
ITEM_ENERGY_PRODUCER_EU_LV = {name=MOD_ENERGY_CONVERTERS .. ":energy_producer_eu", damage=0} -- guess
ITEM_ENERGY_PRODUCER_MJ = {name=MOD_ENERGY_CONVERTERS .. ":energy_producer_mj", damage=0}


-- items: industrial craft items
ITEM_BASIC_MACHINE_CASING = {name=MOD_INDUSTRIAL_CRAFT .. ":resource", damage=12}
ITEM_BATBOX = {name=MOD_INDUSTRIAL_CRAFT .. ":te", damage=72}
ITEM_BATTERY = {name=MOD_INDUSTRIAL_CRAFT .. ":re_battery"}
ITEM_CIRCUIT = {name=MOD_INDUSTRIAL_CRAFT .. ":crafting", damage=1}
ITEM_COIL = {name=MOD_INDUSTRIAL_CRAFT .. ":crafting", damage=5}
ITEM_COPPER_CABLE = {name=MOD_INDUSTRIAL_CRAFT .. ":cable", damage=0}
ITEM_CUTTER = {name=MOD_INDUSTRIAL_CRAFT .. ":cutter"}
ITEM_FORGE_HAMMER = {name=MOD_INDUSTRIAL_CRAFT .. ":forge_hammer"}
ITEM_GENERATOR = {name=MOD_INDUSTRIAL_CRAFT .. ":te", damage=3}
ITEM_INSULATED_COPPER_CABLE = {name=MOD_INDUSTRIAL_CRAFT .. ":cable", damage=0}
ITEM_INSULATED_TIN_CABLE = {name=MOD_INDUSTRIAL_CRAFT .. ":cable", damage=4}
ITEM_IRON_FURNACE = {name=MOD_INDUSTRIAL_CRAFT .. ":te", damage=46}
ITEM_LV_TRANSFORMER = {name=MOD_INDUSTRIAL_CRAFT .. ":te", damage=77}
ITEM_RUBBER = {name=MOD_INDUSTRIAL_CRAFT .. ":crafting", damage=0}
ITEM_SOLAR_PANEL = {name=MOD_INDUSTRIAL_CRAFT .. ":te", damage=8}
ITEM_TIN_CASING = {name=MOD_INDUSTRIAL_CRAFT .. ":casing", damage=6}


-- items: thermal foundation
ITEM_BRONZE_INGOT = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=163}
ITEM_COPPER_DUST = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=64}
ITEM_COPPER_INGOT = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=128}
ITEM_COPPER_PLATE = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=320}
ITEM_DIAMOND_GEAR = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=26}
ITEM_GOLD_GEAR = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=25}
ITEM_IRON_GEAR = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=24}
ITEM_IRON_PLATE = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=32}
ITEM_PULVERIZED_COAL={name=MOD_THERMAL_FOUNDATION .. ":material", damage=768}
ITEM_STONE_GEAR = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=23}
ITEM_TIN_DUST = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=65}
ITEM_TIN_INGOT = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=129}
ITEM_TIN_PLATE = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=321}
ITEM_WOODEN_GEAR = {name=MOD_THERMAL_FOUNDATION .. ":material", damage=22}


-- recipes
--  these should only use ITEM_* constants, for consistency


-- recipes: minecraft recipes
RECIPE_DIAMOND_PICKAXE = {{"ddd", ".s", ".s"}, {d=ITEM_DIAMOND, s=ITEM_STICK}}
RECIPE_FURNACE = {{"ccc", "c.c", "ccc"}, {c=ITEM_COBBLESTONE}}
RECIPE_PLANKS = {{"w"}, {w=ITEM_LOG}}
RECIPE_PISTON = {{"ppp", "sis", "srs"}, {p=ITEM_PLANKS, s=ITEM_COBBLESTONE, i=ITEM_IRON_INGOT, r=ITEM_REDSTONE}}
RECIPE_STICK = {{"p", "p"}, {p=ITEM_PLANKS}}


-- recipes: buildcraft recipes
RECIPE_DIAMOND_GEAR = {{".d", "d.d", ".d"}, {d=ITEM_DIAMOND}}
RECIPE_GOLD_GEAR = {{".g", "g.g", ".g"}, {g=ITEM_GOLD_INGOT}}
RECIPE_IRON_GEAR = {{".i", "i.i", ".i"}, {i=ITEM_IRON_INGOT}}
RECIPE_QUARRY = {{"iri", "gig", "dpd"}, {
  i=ITEM_IRON_GEAR, r=ITEM_REDSTONE, g=ITEM_GOLD_GEAR, d=ITEM_DIAMOND_GEAR, p=ITEM_DIAMOND_PICKAXE
}}
RECIPE_STIRLING_ENGINE = {{"sss", ".g", "GpG"}, {s=ITEM_COBBLESTONE, g=ITEM_GLASS, G=ITEM_STONE_GEAR, p=ITEM_PISTON}}
RECIPE_STONE_GEAR = {{".s", "sgs", ".s"}, {s=ITEM_STONE, g=ITEM_WOODEN_GEAR}}
RECIPE_WOODEN_GEAR = {{".s", "s.s", ".s"}, {s=ITEM_STICK}}
RECIPE_WOODEN_PIPE = {{"pgp"}, {p=ITEM_PLANKS, g=ITEM_GLASS}}


-- recipes: energy converters
RECIPE_ENERGY_CONSUMER_EU_LV = {{"p"}, {p=ITEM_ENERGY_PRODUCER_EU_LV}}
RECIPE_ENERGY_PRODUCER_EU_LV = {{"scs", "tmg", "sCs"}, {
  s=ITEM_STONE, c=ITEM_INSULATED_TIN_CABLE, t=ITEM_LV_TRANSFORMER,
  i=ITEM_BASIC_MACHINE_CASING, g=ITEM_GOLD_INGOT, C=ITEM_COIL
}}
RECIPE_ENERGY_PRODUCER_MJ = {{"sis", "epg", "sis"}, {
  s=ITEM_STONE, i=ITEM_IRON_GEAR,
  e=ITEM_STIRLING_ENGINE, p=ITEM_WOODEN_PIPE, g=ITEM_GOLD_INGOT
}}

-- recipes: industrial craft recipes
--  note: cables cannot be automatically crafted at this time because of how getItemDetail() does not
--    manage to return enough information about items
RECIPE_BASIC_MACHINE_CASING = {{"ppp", "p.p", "ppp"}, {p=ITEM_IRON_PLATE}}
RECIPE_BATBOX = {{"pcp", "bbb", "ppp"}, {p=ITEM_PLANKS, c=ITEM_INSULATED_TIN_CABLE, b=ITEM_BATTERY}}
RECIPE_BATTERY = {{".w", "crc", "crc"}, {w=ITEM_INSULATED_TIN_CABLE, c=ITEM_TIN_CASING, r=ITEM_REDSTONE}}
RECIPE_COPPER_CABLE = {{"cp"}, {c=ITEM_CUTTER, p=ITEM_COPPER_PLATE}}
RECIPE_CIRCUIT = {{"ccc", "rpr", "ccc"}, {c=ITEM_INSULATED_COPPER_CABLE, r=ITEM_REDSTONE, p=ITEM_IRON_PLATE}}
RECIPE_CUTTER = {{"p.p", ".p", "i.i"}, {p=ITEM_IRON_PLATE, i=ITEM_IRON_INGOT}}
RECIPE_FORGE_HAMMER = {{"ii", "iss", "ii"}, {i=ITEM_IRON_INGOT, s=ITEM_STICK}}
RECIPE_GENERATOR = {{".b", "ppp", ".f"}, {b=ITEM_BATTERY, p=ITEM_IRON_PLATE, f=ITEM_IRON_FURNACE}}
-- RECIPE_INSULATED_COPPER_CABLE = {{"rw"}, {r=ITEM_RUBBER, w=ITEM_COPPER_CABLE}}
RECIPE_IRON_FURNACE = {{".p", "p.p", "pfp"}, {p=ITEM_IRON_PLATE, f=ITEM_FURNACE}}
RECIPE_LV_TRANSFORMER = {{"ptp", "pcp", "ptp"}, {p=ITEM_PLANKS, t=ITEM_INSULATED_TIN_CABLE, c=ITEM_COIL}}
RECIPE_LV_SOLAR_ARRAY = {{"ppp", "ptp", "ppp"}, {p=ITEM_SOLAR_PANEL, t=ITEM_LV_TRANSFORMER}}
RECIPE_SOLAR_PANEL = {{"pgp", "gpg", "cGc"}, {
  p=ITEM_PULVERIZED_COAL, g=ITEM_GLASS, c=ITEM_CIRCUIT, G=ITEM_GENERATOR
}}


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
  ITEM_DIAMOND_PICKAXE=RECIPE_DIAMOND_PICKAXE,
  ITEM_FURNACE=RECIPE_FURNACE,
  ITEM_PISTON=RECIPE_PISTON,
  ITEM_PLANKS=RECIPE_PLANKS,
  ITEM_STICK=RECIPE_STICK,

  -- buildcraft item recipes
  ITEM_QUARRY=RECIPE_QUARRY,
  ITEM_STIRLING_ENGINE=RECIPE_STIRLING_ENGINE,
  ITEM_STONE_GEAR=RECIPE_STONE_GEAR,
  ITEM_WOODEN_GEAR=RECIPE_WOODEN_GEAR,
  ITEM_WOODEN_PIPE=RECIPE_WOODEN_PIPE,

  -- energy converter recipes
  ITEM_ENERGY_CONSUMER_EU_LV=RECIPE_ENERGY_CONSUMER_EU_LV,

  -- industrial craft item recipes
  ITEM_BASIC_MACHINE_CASING=RECIPE_BASIC_MACHINE_CASING,
  ITEM_BATBOX=RECIPE_BATBOX,
  ITEM_BATTERY=RECIPE_BATTERY,
  ITEM_CIRCUIT=RECIPE_CIRCUIT,
  ITEM_COPPER_CABLE=RECIPE_COPPER_CABLE,
  ITEM_CUTTER=RECIPE_CUTTER,
  ITEM_FORGE_HAMMER=RECIPE_FORGE_HAMMER,
  ITEM_GENERATOR=RECIPE_GENERATOR,
  ITEM_INSULATED_COPPER_CABLE=RECIPE_INSULATED_COPPER_CABLE,
  ITEM_IRON_FURNACE=RECIPE_IRON_FURNACE,
  ITEM_LV_TRANSFORMER=RECIPE_LV_TRANSFORMER,
  ITEM_SOLAR_PANEL=RECIPE_SOLAR_PANEL,

  -- thermal foundation
  ITEM_COPPER_PLATE=RECIPE_COPPER_PLATE,
  ITEM_DIAMOND_GEAR=RECIPE_DIAMOND_GEAR,
  ITEM_GOLD_GEAR=RECIPE_GOLD_GEAR,
  ITEM_IRON_GEAR=RECIPE_IRON_GEAR,
  ITEM_IRON_PLATE=RECIPE_IRON_PLATE,
  ITEM_TIN_CASING=RECIPE_TIN_CASING,
  ITEM_TIN_PLATE=RECIPE_TIN_PLATE

}
