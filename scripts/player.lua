function playerStore(player, gameBox)
    safeStore(player.baseTokens, gameBox)
    safeStore(player.baseItems, gameBox)
    safeStore(player.playerAreaItems, gameBox)
    safeStore(player.lesserFactions, gameBox)
    safeStore(player.standardEquipTokens, gameBox)
end

function playerHand(player, gameBox, techDeck)
    forEach(player.standardEquipment, function(card) safePlace(techDeck, card, gameBox) end)
    forEach(player.playerAreaItems, function(item) safePlace(gameBox, item) end)
end

function playerLesserFaction(player, destinationBase, gameBox)
    forEach(
        player.lesserFactions,
      function(faction)
        safePlace(gameBox, {
            guid = faction.guid,
            position = faction.positions[destinationBase].position,
            rotation = faction.positions[destinationBase].rotation,
        })
      end)
end

function playerHomeBase(player, gameBox)
    forEach(player.baseItems,function(baseItem) safePlace(gameBox, baseItem) end)
end