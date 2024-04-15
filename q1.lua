local storageKey = 1000 -- replace with proper name, that represent what it is used for

function onLogout(player)
    if player:getStorageValue(storageKey) == 1 then
        player:setStorageValue(storageKey, -1)
    end
    return true
end


-- Postscript

-- Issue 1: Use of magic number 1000 for storage key. What does it refer to? Usually, it is hard
-- to guess what those numbers mean. It is better to move them into variables with meaningful names.
-- It also helps with refactoring, because you can change the value in one place and it will be reflected.

-- The 1000 in addEvent on the other hand is acceptable, because from function signature it is clear that
-- it represents delay in milliseconds.

-- Issue 2: From the context of the code, there is no reason to delay the release of storage value. It can be
-- done immediately. If there is a reason for the delay, it should be documented in the code. Therefore, I moved
-- the releaseStorage function call to onLogout function.