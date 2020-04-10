-- Reacting to switching wifi
-- When switching wifi networks always set the volume to zero
wifiWatcher = nil
lastSSID = nil
function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if newSSID ~= lastSSID then
        -- hs.audiodevice.defaultOutputDevice():setVolume(0)
        output:setMuted(true)
        hs.notify.new({title="Wifi Network has changed", informativeText=newSSID}):send()
    end

    lastSSID = newSSID
end
wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
