require("utilities")
require("pieces")
require("player")
require("player1")
require("player2")
require("player3")
require("player4")
require("empire")
require("infinite")

function initialise()
  gameBox = safeGet('5578eb')
  showHideSetup(gameBox, true)
end

function setup(numberOfPlayers)
  playerNum = numberOfPlayers
  gameBox = safeGet('5578eb')
  showHideSetup(gameBox, false)
  forEach(gameTokens, function(bag) safePlace(gameBox, bag) end)
  forEach(gameDice, function(dice) safePlace(gameBox, dice) end)
  setupDecks(gameBox)
  techDeck = safeGet('fdc0ef')

  playerHand(player1, gameBox, techDeck)
  playerHomeBase(player1, gameBox)

  playerHand(player2, gameBox, techDeck)
  playerHomeBase(player2, gameBox)

  if numberOfPlayers == 2 then
    playerLesserFaction(player1, 4, gameBox)
    playerLesserFaction(player2, 3, gameBox)
  end
  if numberOfPlayers == 3 then
    playerLesserFaction(player1, 6, gameBox)
    playerLesserFaction(player2, 5, gameBox)
    playerLesserFaction(player3, 4, gameBox)

    playerHand(player3, gameBox, techDeck)
    playerHomeBase(player3, gameBox)
  end
  if numberOfPlayers == 4 then
    playerHand(player3, gameBox, techDeck)
    playerHomeBase(player3, gameBox)
    playerHand(player4, gameBox, techDeck)
    playerHomeBase(player4, gameBox)
    playerLesserFaction(player1, 6, gameBox)
    playerLesserFaction(player2, 5, gameBox)
  end
end

function setup4()
  setup(4)
end

function setup3()
  setup(3)
end

function setup2()
    setup(2)
end

function infinitePower()
  if playerNum == nil then
    broadcastToAll("Select number of players first")
  else
    deployInfinitePower(playerNum)
  end
end

function showHideSetup(gameBox, show)
    local gameCardGuid =  'bd071d'
    local initialised = safeGet(gameCardGuid, false)
    local pos = nil
    if (show) then
      pos = { x = -0.276353687047958, y = 1.75116384029388, z = -9.73142337799072 }
      playerNum = nil
    else
      pos = { x = -21.8093719482422, y = 3.62151789665222, z = 19.8184719085693 }
    end

    -- Setup card
    safePlace(gameBox, {
      guid = gameCardGuid,
      position = pos,
      rotation = { x = 1.21824878078769E-05, y = 180.018188476563, z = -5.90269344613672E-08 }
    })

    if initialised == nil then
      createButton(gameCardGuid, '2 Player', 'setup2', {-0.41,0.2,-0.20}, 150, 35)
      createButton(gameCardGuid, '3 Player', 'setup3', {0.41,0.2,-0.20}, 150, 35)
      createButton(gameCardGuid, '4 Player', 'setup4', {0,0.2,-0.38}, 150, 35)
      createButton(gameCardGuid, 'Reset\nGame', 'reset', {0,0.2,0.38}, 150, 35)
      createButton(gameCardGuid, 'Empire\nInvasion', 'empireInvasion', {-0.47,0.2,0.60}, 135, 30)
      createButton(gameCardGuid, 'Reset', 'resetEmpire', {-0.47,0.2,0.83}, 85, 30)
      createButton(gameCardGuid, 'Infinite\nPower', 'infinitePower', {0.45,0.2,0.60}, 135, 30)
      createButton(gameCardGuid, 'Reset', 'resetInfinite', {0.45,0.2,0.83}, 85, 30)
    end
end

function setupDecks(gameBox)
  -- Missions 1
  safePlace(gameBox,   {
    guid = '23d5eb',
    position = { x = 13.1496429443359, y = 1.82023596763611, z = 3.34581780433655 },
    rotation = { x = 7.34382228984032E-06, y = 180.01936340332, z = 180 },
    callback_function = function ()
      m1Deck = safeGet('23d5eb')
      m1Deck.shuffle()
      m1Deck.deal(1)
    end
  })
  -- Missions 2
  safePlace(gameBox,   {
    guid = '2d58fe',
    position = { x = 13.1729412078857, y = 1.81060779094696, z = -0.149963244795799 },
    rotation = { x = 5.63130060982076E-06, y = 179.999954223633, z = 180 },
    callback_function = function ()
      m2Deck = safeGet('2d58fe')
      m2Deck.shuffle()
    end
  })
  -- Missions 3
  safePlace(gameBox,   {
    guid = 'f8bd3e',
    position = { x = 13.231912612915, y = 1.80097949504852, z = -3.58059477806091 },
    rotation = { x = 5.92514697927982E-06, y = 180, z = 180 },
    callback_function = function ()
      m3Deck = safeGet('f8bd3e')
      m3Deck.shuffle()
    end
  })
  -- Tech Deck
  safePlace(gameBox, {
    guid = 'fdc0ef',
    position = { x = -11.8115930557251, y = 1.99835515022278, z = 0.642340362071991 },
    rotation = { x = 6.50481479169684E-06, y = 180.024291992188, z = 180 },
    callback_function = function ()
      techDeck = safeGet('fdc0ef')
      techDeck.shuffle()
    end
  })

end

function resetInfinite()
  storeInfinite(gameBox)
end

function resetEmpire()
  storeEmpire(gameBox)
end

function storeInBox()
    gameBox = safeGet('5578eb')
    safeStore(gameTokens, gameBox)
    safeStore(gameDice, gameBox)
    storeDecks(gameBox)
    storePlayers(gameBox)
    storeEmpire(gameBox)
    storeInfinite(gameBox)
    showHideSetup(gameBox, true)
end

function storeDecks(gameBox)
  storeDeck(m1Deck, gameBox)
  storeDeck(m2Deck, gameBox)
  storeDeck(m3Deck, gameBox)
  storeDeck(techDeck, gameBox)
end

function storeDeck(deck, gameBox)
  if deck ~= nil then
    deck.reset()
    local watchDeck = function () return deck.resting end
    Wait.condition(function() safeStore({ deck }, gameBox) end, watchDeck)
  end
end

function storePlayers(gameBox)
  playerStore(player1, gameBox)
  playerStore(player2, gameBox)
  playerStore(player3, gameBox)
  playerStore(player4, gameBox)
end