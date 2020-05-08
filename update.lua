#!/bin/lua

local setup_lua = "setup.lua"
local root_setup_lua = "/" .. setup_lua

-- remove old setup script
if fs.exists(root_setup_lua) then
  fs.delete(root_setup_lua)
end

-- download the setup script
shell.run("wget https://raw.github.com/IanWernecke/ccturtle/master/" .. setup_lua .. " " .. setup_lua)

-- call the setup script and reboot
shell.run(root_setup_lua)
shell.run("reboot")
