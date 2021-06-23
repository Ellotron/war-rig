function playerStore(player, gameBox)
    if player.baseTokens ~= nil then
        safeStore(player.baseTokens, gameBox)
    end
    if player.baseItems ~= nil then
        safeStore(player.baseItems, gameBox)
    end
    if player.playerAreaItems ~= nil then
        safeStore(player.playerAreaItems, gameBox)
    end
    if player.lesserFactions ~= nil then
        safeStore(player.lesserFactions, gameBox)
    end
    if player.standardEquipTokens ~= nil then
        safeStore(player.standardEquipTokens, gameBox)
    end

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