require("utilities")
require("pieces")
require("player")
require("player1")
require("player2")
require("player3")
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
  forEach(gameBags, function(bag) safePlace(gameBox, bag) end)
  forEach(gameDice, function(dice) safePlace(gameBox, dice) end)
  setupDecks(gameBox)
  techDeck = safeGet('6b38f9')

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
end

function setup3()
  setup(3)
end

function setup2()
    setup(2)
end

function infinitePower()
  if playerNum == nil then
    print("Select number of players first")
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
      createButton(gameCardGuid, 'Reset', 'reset', {0,0.2,0.38}, 150, 35)
      createButton(gameCardGuid, 'Empire\nInvasion', 'empireInvasion', {-0.47,0.2,0.65}, 135, 30)
      createButton(gameCardGuid, 'Infinite\nPower', 'infinitePower', {0.45,0.2,0.65}, 135, 30)
    end
end

function setupDecks(gameBox)
  -- Tech Deck
  safePlace(gameBox, {
    guid = '6b38f9',
    position = { x = -11.8115930557251, y = 1.99835515022278, z = 0.642340362071991 },
    rotation = { x = 6.50481479169684E-06, y = 180.024291992188, z = 180 },
    callback_function = function ()
      techDeck = safeGet('6b38f9')
      techDeck.shuffle()
    end
  })

end

function storeInBox()
    gameBox = safeGet('5578eb')
    safeStore(gameBags, gameBox)
    safeStore(gameDice, gameBox)
    storeDecks(gameBox)
    storePlayers(gameBox)
    storeEmpire(gameBox)
    storeInfinite(gameBox)
    showHideSetup(gameBox, true)
end

function storeDecks(gameBox)
    -- Tech Deck
    techDeck.reset()
    local watchDeck = function () return techDeck.resting end
    Wait.condition(function() safeStore({ techDeck }, gameBox) end, watchDeck)
end

function storePlayers(gameBox)
  playerStore(player1, gameBox)
  playerStore(player2, gameBox)
  playerStore(player3, gameBox)
end