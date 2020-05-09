-- constants
local src = "https://raw.github.com/IanWernecke/ccturtle/master/"
local dst = nil
if turtle then
   dst = "/"
else
  dst = "/turtle/"
  if fs.exists("/turtle/") then
      fs.delete("/turtle/")
  end
end

-- simple function to write data to files
local function download(data, file)
   local f = fs.open(file, "w")
   f.write(data)
   f.close()
end

local directories = {
  "/turtle/.",
  "/turtle/apis",
  "/turtle/bore",
  "/turtle/build",
  "/turtle/clear",
  "/turtle/clear/forward",
  "/turtle/clear/magnet",
  "/turtle/clear/magnet/spiral",
  "/turtle/clear/shelf",
  "/turtle/clear/spiral",
  "/turtle/craft",
  "/turtle/describe",
  "/turtle/dig",
  "/turtle/fill",
  "/turtle/fill/spiral",
  "/turtle/inventory",
  "/turtle/mine",
  "/turtle/mine/stairs",
  "/turtle/mine/vein",
  "/turtle/move",
  "/turtle/place",
  "/turtle/punch",
  "/turtle/seek",
  "/turtle/slide",
  "/turtle/strafe",
  "/turtle/util"
}

local files = {
  "basic.lua",
  "sanitize.lua",
  "setup.lua",
  "startup",
  "update.lua",
  "apis/args.lua",
  "apis/basic.lua",
  "apis/bore.lua",
  "apis/builder.lua",
  "apis/clear.lua",
  "apis/cleft.lua",
  "apis/common.lua",
  "apis/con.lua",
  "apis/describe.lua",
  "apis/detect.lua",
  "apis/dig.lua",
  "apis/fill.lua",
  "apis/inventory.lua",
  "apis/match.lua",
  "apis/mine.lua",
  "apis/move.lua",
  "apis/opt.lua",
  "apis/ore.lua",
  "apis/place.lua",
  "apis/punch.lua",
  "apis/recipes.lua",
  "apis/seek.lua",
  "apis/slide.lua",
  "apis/turn.lua",
  "bore/back.lua",
  "bore/down.lua",
  "bore/forward.lua",
  "bore/left.lua",
  "bore/right.lua",
  "bore/up.lua",
  "build/catwalk.lua",
  "build/farm.lua",
  "build/frame.lua",
  "build/house.lua",
  "build/skyduct.lua",
  "build/skyway.lua",
  "build/wall.lua",
  "build/walls.lua",
  "clear/tunnel.lua",
  "clear/forward/both.lua",
  "clear/forward/left.lua",
  "clear/forward/right.lua",
  "clear/magnet/spiral/left.lua",
  "clear/magnet/spiral/right.lua",
  "clear/shelf/left.lua",
  "clear/shelf/right.lua",
  "clear/spiral/left.lua",
  "clear/spiral/right.lua",
  "craft/batbox.lua",
  "craft/generator.lua",
  "craft/hammer.lua",
  "craft/solar-panel.lua",
  "describe/back.lua",
  "describe/down.lua",
  "describe/forward.lua",
  "describe/left.lua",
  "describe/right.lua",
  "describe/up.lua",
  "dig/back.lua",
  "dig/down.lua",
  "dig/forward.lua",
  "dig/left.lua",
  "dig/right.lua",
  "dig/up.lua",
  "fill/auto.lua",
  "fill/back.lua",
  "fill/down.lua",
  "fill/forward.lua",
  "fill/gap.lua",
  "fill/layer.lua",
  "fill/left.lua",
  "fill/right.lua",
  "fill/up.lua",
  "fill/spiral/left.lua",
  "fill/spiral/right.lua",
  "inventory/count.lua",
  "inventory/drop.lua",
  "inventory/select.lua",
  "mine/canal.lua",
  "mine/ores.lua",
  "mine/shaft.lua",
  "mine/shafts.lua",
  "mine/skylight.lua",
  "mine/skystone.lua",
  "mine/trench.lua",
  "mine/trenchSeek.lua",
  "mine/tunnel.lua",
  "mine/stairs/down.lua",
  "mine/stairs/up.lua",
  "mine/vein/back.lua",
  "mine/vein/down.lua",
  "mine/vein/forward.lua",
  "mine/vein/left.lua",
  "mine/vein/right.lua",
  "mine/vein/up.lua",
  "move/back.lua",
  "move/climb.lua",
  "move/down.lua",
  "move/forward.lua",
  "move/left.lua",
  "move/magnet.lua",
  "move/right.lua",
  "move/up.lua",
  "place/back.lua",
  "place/down.lua",
  "place/forward.lua",
  "place/left.lua",
  "place/right.lua",
  "place/up.lua",
  "punch/back.lua",
  "punch/down.lua",
  "punch/forward.lua",
  "punch/left.lua",
  "punch/right.lua",
  "punch/up.lua",
  "seek/back.lua",
  "seek/down.lua",
  "seek/forward.lua",
  "seek/left.lua",
  "seek/right.lua",
  "seek/up.lua",
  "slide/back.lua",
  "slide/down.lua",
  "slide/forward.lua",
  "slide/left.lua",
  "slide/right.lua",
  "slide/up.lua",
  "strafe/left.lua",
  "strafe/right.lua",
  "util/detail.lua",
  "util/select.lua",
  "util/stub.lua"
}

-- tie each path to a request path
local requests = {}
for i=1,#files do
   requests[src..files[i]] = dst..files[i]
end

-- make each of the required directories
for i=1,#directories do
   fs.makeDir(directories[i])
end

-- request each of the files to be retrieved
for key,value in pairs(requests) do
   http.request(key)
end

-- asynchronously download all of the files
local downloaded = 0
local failed = {}
while downloaded < #files do
   local event, url, handle = os.pullEvent()
   if event == "http_success" then
       download(handle.readAll(), requests[url])
       downloaded = downloaded + 1
   elseif event == "http_failure" then
       failed[os.startTimer(3)] = url
   elseif event == "timer" and failed[url] then
       print("fail: "..url)
       http.request(failed[url])
   end
end
