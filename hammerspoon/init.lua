-- package.path = os.getenv('HOME') .. '/.dotfiles/hammerspoon/?.lua;' .. package.path

require("modules/spoons")
require("modules/windows")
require("modules/layouts")
require("modules/finder")

-- Utility stuff
require("modules/wifiwatcher")
require("modules/muteOnWake")
require("modules/dontFuckWithPaste")
require("modules/applicationMenuHacks")
require("modules/whereIsMouse")
require("modules/tabSearch");


-- RELOAD Config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
-- this is here since any code after hs.reload() would not be called. hs.reload() destroys the current Lua interpreter
hs.alert.show("Config loaded")

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

local display = 17;
hs.hotkey.bind({"ctrl", "cmd", "shift"}, "`", function()
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Help", function()
  if display == 17 then
    display = 15
  else
    display = 17
  end
  hs.execute("/Users/kaks/code/ddcctl/ddcctl -d 1 -i " .. display)
  -- hs.eventtap.keyStroke({}, "ctrl", "cmd"
  -- https://gist.github.com/nonissue/5e6d2de97d24e31347483365911a919c
end)
-- open -g hammerspoon://someAlert
-- hs.urlevent.bind("someAlert", function(eventName, params)
--     hs.alert.show("Received someAlert")
-- end)

-- local tiling = require "hs.tiling"
-- local hotkey = require "hs.hotkey"
-- local mash = {"ctrl", "cmd"}

-- hotkey.bind(mash, "c", function() tiling.cycleLayout() end)
-- hotkey.bind(mash, "j", function() tiling.cycle(1) end)
-- hotkey.bind(mash, "k", function() tiling.cycle(-1) end)
-- hotkey.bind(mash, "space", function() tiling.promote() end)
-- hotkey.bind(mash, "f", function() tiling.goToLayout("fullscreen") end)

-- -- If you want to set the layouts that are enabled
-- tiling.set('layouts', {
--   'fullscreen', 'main-vertical'
-- })

