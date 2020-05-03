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
  "/turtle/build/signal",
  "/turtle/clear",
  "/turtle/clear/forward",
  "/turtle/clear/magnet",
  "/turtle/clear/magnet/spiral",
  "/turtle/clear/shelf",
  "/turtle/clear/spiral",
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
  "basic",
  "sanitize",
  "setup",
  "startup",
  "test",
  "update",
  "apis/basic",
  "apis/bore",
  "apis/builder",
  "apis/clear",
  "apis/cleft",
  "apis/con",
  "apis/describe",
  "apis/detect",
  "apis/dig",
  "apis/fill",
  "apis/inventory",
  "apis/match",
  "apis/mine",
  "apis/move",
  "apis/opt",
  "apis/ore",
  "apis/place",
  "apis/punch",
  "apis/replace",
  "apis/seek",
  "apis/slide",
  "apis/turn",
  "bore/back",
  "bore/down",
  "bore/forward",
  "bore/left",
  "bore/right",
  "bore/up",
  "build/catwalk",
  "build/farm",
  "build/frame",
  "build/house",
  "build/skyduct",
  "build/skyway",
  "build/wall",
  "build/walls",
  "build/signal/home",
  "clear/tunnel",
  "clear/forward/both",
  "clear/forward/left",
  "clear/forward/right",
  "clear/magnet/spiral/left",
  "clear/magnet/spiral/right",
  "clear/shelf/left",
  "clear/shelf/right",
  "clear/spiral/left",
  "clear/spiral/right",
  "describe/back",
  "describe/down",
  "describe/forward",
  "describe/left",
  "describe/right",
  "describe/up",
  "dig/back",
  "dig/down",
  "dig/forward",
  "dig/left",
  "dig/right",
  "dig/up",
  "fill/auto",
  "fill/back",
  "fill/down",
  "fill/forward",
  "fill/gap",
  "fill/layer",
  "fill/left",
  "fill/right",
  "fill/up",
  "fill/spiral/left",
  "fill/spiral/right",
  "inventory/count",
  "inventory/drop",
  "inventory/select",
  "mine/canal",
  "mine/ores",
  "mine/shaft",
  "mine/shafts",
  "mine/skylight",
  "mine/skystone",
  "mine/trench",
  "mine/trenchSeek",
  "mine/tunnel",
  "mine/stairs/down",
  "mine/stairs/up",
  "mine/vein/back",
  "mine/vein/down",
  "mine/vein/forward",
  "mine/vein/left",
  "mine/vein/right",
  "mine/vein/up",
  "move/back",
  "move/climb",
  "move/down",
  "move/forward",
  "move/left",
  "move/magnet",
  "move/right",
  "move/up",
  "place/back",
  "place/down",
  "place/forward",
  "place/left",
  "place/right",
  "place/up",
  "punch/back",
  "punch/down",
  "punch/forward",
  "punch/left",
  "punch/right",
  "punch/up",
  "seek/back",
  "seek/down",
  "seek/forward",
  "seek/left",
  "seek/right",
  "seek/up",
  "slide/back",
  "slide/down",
  "slide/forward",
  "slide/left",
  "slide/right",
  "slide/up",
  "strafe/left",
  "strafe/right",
  "util/detail",
  "util/select",
  "util/stub"
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
while downloaded < 133 do
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
