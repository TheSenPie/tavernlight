function do_sth_with_PlayerParty(playerId, membername)
    player = Player(playerId)
    member = Player(membername)
    if not player then
        return
    end

    local party = player:getParty()

    if not party then
        return
    end

    party:removeMember(member)
end

-- Postscript
-- Issue 1: Should check for nil if the player and member. Same goes for getParty().
-- Issue 2: Can replace all of the for loop with party:removeMember(member) function call.
-- It does the same thing and is more readable.
-- Issue 3: Also, in the loop it would call Player(membername) on every iteration.
-- It is better to call it once and store it in a variable. 