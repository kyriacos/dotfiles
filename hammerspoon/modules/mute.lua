local hyper     = {"ctrl", "alt", "cmd"}
local lesshyper = {"ctrl", "alt"}
spoon.GlobalMute:bindHotkeys({
  unmute = {lesshyper, "u"},
  mute   = {lesshyper, "m"},
  toggle = {hyper, "space"}
})
spoon.GlobalMute:configure({
  unmute_background = 'file:///Library/Desktop%20Pictures/Solid%20Colors/Red%20Orange.png',
  mute_background   = 'file:///Library/Desktop%20Pictures/Solid%20Colors/Turquoise%20Green.png',
  enforce_desired_state = true,
  stop_sococo_for_zoom  = true,
  unmute_title = "<---- THEY CAN HEAR YOU -----",
  mute_title = "<-- MUTE",
  -- change_screens = "SCREENNAME1, SCREENNAME2"  -- This will only change the background of the specific screens.  string.find()
})
spoon.GlobalMute._logger.level = 3
