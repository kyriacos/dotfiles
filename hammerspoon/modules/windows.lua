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
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Left', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Right', baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Down', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Up', baseMove(0, 0, 1, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '1', baseMove(0, 0, 0.5, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '2', baseMove(0.5, 0, 0.5, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '3', baseMove(0, 0.5, 0.5, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '4', baseMove(0.5, 0.5, 0.5, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'M', baseMove(0, 0, 1, 1)) -- hs.grid.maximizeWindow

-- focus, center and hide all other windows
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'F', function()
    local win = hs.window.focusedWindow()
    local visibleWindows = hs.window.visibleWindows()

    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x+(max.w/2-(max.w*0.4))
    f.y = max.y+(max.h/2-(max.h*0.4))
    f.w = max.w * 0.8
    f.h = max.h * 0.8
    win:setFrame(f, 0)

    for i, owin in ipairs(visibleWindows) do
        if owin and win:application() ~= owin:application() then
            local app = owin:application()
            app:hide()
        end
    end
end)

-- Expose
expose = hs.expose.new(nil,{showThumbnails=true})
hs.hotkey.bind('ctrl-cmd-alt','e','Expose',function()expose:toggleShow()end)


-- lock screen shortcut
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'L', function() hs.caffeinate.startScreensaver() end)

-- Focus applications
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'C', function () hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'T', function () hs.application.launchOrFocus("iTerm") end)

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
hs.hotkey.bind({'cmd','alt','ctrl'}, 'space', cascadeWindows)

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
