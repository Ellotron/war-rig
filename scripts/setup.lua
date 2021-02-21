require("utilities")
require("setupDice")
require("pieces")
require("player")
require("player1")
require("player2")
require("player3")
require("empire")

function createButton(guid, label, functionName, position, size, font_size)
    position = position or {0,0.2,0}
    size = size or 500
    but = safeGet(guid)
    but.createButton({
       click_function = functionName,
       function_owner = nil,
       label          = label,
       position       = position,
       rotation       = {0,0,0},
       width          = size,
       height         = size,
       font_size      = font_size or 200,
    })
end

function initialise()
  gameBox = safeGet('5578eb')
  showHideSetup(gameBox, true)
end

function setup(numberOfPlayers)
  gameBox = safeGet('5578eb')
  showHideSetup(gameBox, false)
  setupBags(gameBox)
  setupDice(gameBox)
  setupDecks(gameBox)
  techDeck = getObjectFromGUID('35e89c')

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
  print("TODO")
end

function showHideSetup(gameBox, show)
    local gameCardGuid =  'bd071d'
    gameCard = safeGet(gameCardGuid, false)

    if (show) then
      local pos = { x = -0.276353687047958, y = 1.75116384029388, z = -9.73142337799072 }
      if gameCard then
        gameCard.setPositionSmooth(pos, false, true)
        else
        -- Setup card
        safeTake(gameBox, {
          guid = gameCardGuid,
          position = pos,
          rotation = { x = 1.21824878078769E-05, y = 180.018188476563, z = -5.90269344613672E-08 }
        })

        createButton(gameCardGuid, '2 Player', 'setup2', {-0.41,0.2,-0.20}, 150, 35)
        createButton(gameCardGuid, '3 Player', 'setup3', {0.41,0.2,-0.20}, 150, 35)
        createButton(gameCardGuid, 'Reset', 'reset', {0,0.2,0.38}, 150, 35)
        createButton(gameCardGuid, 'Empire\nInvasion', 'empireInvasion', {-0.47,0.2,0.65}, 135, 30)
        createButton(gameCardGuid, 'Infinite\nPower', 'infinitePower', {0.45,0.2,0.65}, 135, 30)
      end
    else
      -- Setup card
      gameCard.setPositionSmooth({ x = -21.8093719482422, y = 3.62151789665222, z = 19.8184719085693 }, false, true)
    end
end

function setupBags(gameBox)
    forEach(gameBags, function(bag) safeTake(gameBox, bag) end)
end

function setupDecks(gameBox)
  -- Tech Deck
  safeTake(gameBox, {
    guid = '35e89c',
    position = { x = -11.8115930557251, y = 1.99835515022278, z = 0.642340362071991 },
    rotation = { x = 6.50481479169684E-06, y = 180.024291992188, z = 180 }
  })
end

function storeInBox()
    gameBox = safeGet('5578eb')
    storeBags(gameBox)
    storeDice(gameBox)
    storeDecks(gameBox)
    storePlayers(gameBox)
    storeEmpire(gameBox)
    showHideSetup(gameBox, true)
end

function storeDecks(gameBox)
    -- Tech Deck
    techDeck = safeGet('35e89c')
    cards = concat(player1.standardEquipment, concat(player2.standardEquipment, player3.standardEquipment))
    safeStore(cards, techDeck, function() gameBox.putObject(techDeck) end)
end

function storeBags(gameBox)
  safeStore(gameBags, gameBox)
end

function storePlayers(gameBox)
  playerStore(player1, gameBox)

  playerStore(player2, gameBox)

  playerStore(player3, gameBox)
end