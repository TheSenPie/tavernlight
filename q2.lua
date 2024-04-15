function printSmallGuildNames(memberCount)
    if memberCount == nil or memberCount < 0 then
        print("Invalid member count")
        return
    end
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    selectGuildQuery = string.format(selectGuildQuery, memberCount)
    selectGuildQuery = db.escapeString(selectGuildQuery)
    local resultId = db.storeQuery(selectGuildQuery)
    if resultId then
        repeat
            guildName = result.getString("name")
            print(guildName)
        until not result.next(resultId)
		result.free(resultId)
    end
end

-- Postscript

-- Issue 1: Might want to protect against SQL injection by using db.escapeString on memberCount
-- Issue 2: It's a good practice to check for invalid inputs and warn the user.
-- Check memberCount for nil and negative values and warn the user
-- Issue 3: Previous code wasn't checking if the query was successful.
-- Issue 4: Only first result was being printed. I changed it to print all results.
-- Issue 5: The resultId should be freed.