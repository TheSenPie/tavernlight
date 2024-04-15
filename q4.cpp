void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool isNewPlayer = false;

    if (!player) {
        player = new Player(nullptr);
        isNewPlayer = true;
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (isNewPlayer) {
            delete player;
        }
        return;
    }

    if (g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT) == RETURNVALUE_NOERROR) {
        if (player->isOffline()) {
            IOLoginData::savePlayer(player);
        }
    } else {
        delete item;
    }

    if (isNewPlayer) {
        delete player;
    }
}

/*
    Postscript
    Issue: new Player(nullptr) allocation was not freed at all, let alone the case of failure. Now not only the allocation for player is freed now,
    also the allocation for item is freed in case of failure.
*/