-- Register Hammerspoon Search
if spoon.HSearch and spoon.ModalMgr then
    hsearch_keys = hsearch_keys or {"alt", "G"}
    if string.len(hsearch_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hsearch_keys[1], hsearch_keys[2], 'Launch Hammerspoon Search', function() spoon.HSearch:toggleShow() end)
    end
end

-- Finally we initialize ModalMgr supervisor
if spoon.ModalMgr then
    spoon.ModalMgr.supervisor:enter()
end


