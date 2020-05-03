#!/bin/lua

-- remove old setup script
if fs.exists("/setup") then
  fs.delete("/setup")
end

-- download the setup script
shell.run("wget https://raw.github.com/IanWernecke/ccturtle/master/setup setup")

-- call the setup script
shell.run("/setup")
