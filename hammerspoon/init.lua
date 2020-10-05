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

-- TEST MOVING THE MOUSE POINTER TO THE CURRENTLY FOCUSED WINDOWS
local function focus_other_screen() -- focuses the other screen 
   local screen = hs.mouse.getCurrentScreen()
   local nextScreen = screen:next()
   local rect = nextScreen:fullFrame()
   local center = hs.geometry.rectMidPoint(rect)
   hs.mouse.setAbsolutePosition(center)
end 

function get_window_under_mouse() -- from https://gist.github.com/kizzx2/e542fa74b80b7563045a 
   local my_pos = hs.geometry.new(hs.mouse.getAbsolutePosition())
   local my_screen = hs.mouse.getCurrentScreen()
   return hs.fnutils.find(hs.window.orderedWindows(), function(w)
                 return my_screen == w:screen() and my_pos:inside(w:frame())
   end)
end

function activate_other_screen()
   focus_other_screen() 
   local win = get_window_under_mouse() 
   -- now activate that window 
   win:focus() 
end 

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, "p", function() -- does the keybinding
      activate_other_screen()
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

