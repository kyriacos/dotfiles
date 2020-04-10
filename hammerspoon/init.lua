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


-- RELOAD Config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
-- this is here since any code after hs.reload() would not be called. hs.reload() destroys the current Lua interpreter
hs.alert.show("Config loaded")



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

