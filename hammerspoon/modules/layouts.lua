hs.hotkey.bind({"cmd", "alt", "ctrl"}, "S", function()
  hs.application.enableSpotlightForNameSearches(true)
  local laptopScreen = "BenQ GW2765"
  local windowLayout = {
    {"iTerm2",  nil,          laptopScreen, hs.layout.left50,    nil, nil},
    -- {"iTerm2",  "node",          laptopScreen, hs.layout.left25,    nil, nil},
    {"Google Chrome",    nil,          laptopScreen, hs.layout.right50,   nil, nil},
  }
  hs.application.launchOrFocus("iTerm")
  hs.application.launchOrFocus("Google Chrome")
  hs.layout.apply(windowLayout)
end)

