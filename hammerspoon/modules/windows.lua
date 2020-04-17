-- Disable animation i'd rather not have jerky movement
hs.window.animationDuration = 0
local hyper = {'ctrl','cmd','alt'}


-- Cycle through visible windows on the current screen
local currentWindowSet = {}
local windowCycler = nil

local wf = hs.window.filter.new(function(win)
    local fw = hs.window.focusedWindow()
    return (
    win:isStandard() and
    -- win:application() == fw:application() and
    win:screen() == fw:screen() and
    win:isVisible()
    )
end)

local function makeTableCycler(t)
    local i = 1
    return function(d)
        local j = d and d < 0 and -2 or 0
        i = (i + j) % #t + 1
        local x = t[i]
        return x
    end
end

local function updateWindowCycler()
    if not hs.fnutils.contains(currentWindowSet, hs.window.focusedWindow()) then
        currentWindowSet = wf:getWindows()
        windowCycler = makeTableCycler(currentWindowSet)
    end
end

hs.hotkey.bind(hyper, "]", function()
    updateWindowCycler()
    windowCycler():focus()
end)

hs.hotkey.bind(hyper, "[", function()
    updateWindowCycler()
    windowCycler(-1):focus()
end)


-- WINDOW MOVEMENT
--[[ function factory that takes the multipliers of screen width
and height to produce the window's x pos, y pos, width, and height ]]
function baseMove(x, y, w, h)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        -- add max.x so it stays on the same screen, works with my second screen
        f.x = max.w * x + max.x
        f.y = max.h * y
        f.w = max.w * w
        f.h = max.h * h
        win:setFrame(f, 0)
    end
end

-- feature spectacle/another window sizing apps
hs.hotkey.bind(hyper, 'Left', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind(hyper, 'Right', baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind(hyper, 'Down', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind(hyper, 'Up', baseMove(0, 0, 1, 0.5))
hs.hotkey.bind(hyper, '1', baseMove(0, 0, 0.5, 0.5))
hs.hotkey.bind(hyper, '2', baseMove(0.5, 0, 0.5, 0.5))
hs.hotkey.bind(hyper, '3', baseMove(0, 0.5, 0.5, 0.5))
hs.hotkey.bind(hyper, '4', baseMove(0.5, 0.5, 0.5, 0.5))
hs.hotkey.bind(hyper, 'M', baseMove(0, 0, 1, 1)) -- hs.grid.maximizeWindow

-- focus, center and hide all other windows
function resizeAndCenter(hideAllOthers)
    hideAllOthers = hideAllOthers or false
    centerAllAppWindows = hideAllOthers or false

    local visibleWindows = hs.window.visibleWindows()
    local win = hs.window.focusedWindow()

    function center(w)
      w = w or hs.window.focusedWindow()
      local f = w:frame()
      local screen = w:screen()
      local max = screen:frame()

      f.x = max.x+(max.w/2-(max.w*0.4))
      f.y = max.y+(max.h/2-(max.h*0.4))
      f.w = max.w * 0.8
      f.h = max.h * 0.8
      w:setFrame(f, 0)
    end
    center(win)

    if hideAllOthers then
        for i, owin in ipairs(visibleWindows) do

            if win:application() == owin:application() then
              center(owin)
            end

            if owin and win:application() ~= owin:application() then
                local app = owin:application()
                app:hide()
            end
        end
    end
end
hs.hotkey.bind(hyper, 'F', function() resizeAndCenter(true) end)

-- Resize and center
hs.hotkey.bind(hyper, 'C', resizeAndCenter)

-- Zen
hs.hotkey.bind(hyper, 'Z', function() resizeAndCenter(); hs.execute('defaults write com.apple.finder CreateDesktop false; killall Finder') end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd', 'shift'}, 'Z', function() hs.execute('defaults write com.apple.finder CreateDesktop true; killall Finder') end)

-- Expose
expose = hs.expose.new(nil,{showThumbnails=true})
hs.hotkey.bind(hyper,'e','Expose',function()expose:toggleShow()end)


-- lock screen shortcut
hs.hotkey.bind(hyper, 'L', function() hs.caffeinate.startScreensaver() end)

-- Focus applications
local applicationHotkeys = {
  b = 'Google Chrome',
  t = 'iTerm',
}
for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end

function cascadeWindows()
    local windows = hs.window.allWindows()
    local screen = windows[1]:screen():frame()

    local xMargin, yMargin = screen.w/5, screen.h/5  -- This is equal to the gap between the edge of the topleft window and the edge of the screen.
    local layout = {}
    for i, win in ipairs(windows) do
        local winPos = {
            win:application(),
            win:title(),
            win:screen(),
            nil, hs.geometry.rect(
            (i-1)*(xMargin/(#windows-1)), -- x
            (i-1)*(yMargin/(#windows-1)), -- y, you might end up having to add some number here
            screen.w - xMargin,           -- w
            screen.h - yMargin            -- h
            ), nil
        }
        layout[#layout+1] = winPos
    end
    hs.layout.apply(layout)
end
hs.hotkey.bind(hyper, 'space', cascadeWindows)

-- Rescue Windows
-- Move any windows that are off-screen onto the main screen
function rescueWindows()
    local screen = hs.screen.mainScreen()
    local screenFrame = screen:fullFrame()
    local wins = hs.window.visibleWindows()
    for i,win in ipairs(wins) do
        local frame = win:frame()
        if not frame:inside(screenFrame) then
            win:moveToScreen(screen, true, true)
        end
    end
end
-- return rescueWindows
-- local rescueWindows = require "rescuewindows"
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", rescueWindows)
