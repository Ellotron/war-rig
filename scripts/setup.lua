require("utilities")
require("setupDice")
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
    -- Squad Boards
    safeTake(gameBox, {
        guid = '1a9852',
        position = { x = 26.9216613769531, y = 0.948099672794342, z = 6.83267879486084 },
        rotation = { x = 2.84003181150183E-06, y = -9.72201305557974E-05, z = 1.66527695455443E-06 }
    })
    -- Biological
    safeTake(gameBox, {
    guid = 'e1d805',
    position = { x = 22.8184547424316, y = 1.73926436901093, z = -8.26023960113525 },
    rotation = { x = -5.15348619956058E-06, y = -3.20392573485151E-05, z = -3.79103752834453E-08 }
  })
  -- Chemicals
  safeTake(gameBox, {
    guid = '657d69',
    position = { x = 22.7814159393311, y = 1.73926436901093, z = -5.74489068984985 },
    rotation = { x = -6.49826688459143E-07, y = -3.24362990795635E-05, z = -5.19074433213973E-07 }
  })
  -- Fire Tokens
  safeTake(gameBox, {
    guid = '26cac4',
    position = { x = 26.6121196746826, y = 0.948099970817566, z = -2.10684680938721 },
    rotation = { x = -1.44787393185908E-09, y = -6.17518526269123E-05, z = 7.77094015802504E-08 }
  })
  -- Tech
  safeTake(gameBox, {
    guid = '35fa01',
    position = { x = 4.25365543365479, y = 1.73926401138306, z = -9.77801418304443 },
    rotation = { x = -6.31945795248612E-06, y = -6.79706281516701E-05, z = -3.56705101012267E-07 }
  })
  -- Scrap
  safeTake(gameBox, {
    guid = '5f986f',
    position = { x = 4.945228099823, y = 1.73926472663879, z = 0.0404360517859459 },
    rotation = { x = -1.89839954600757E-06, y = -6.1837286921218E-05, z = -3.25284389646185E-07 }
  })
  -- Camp Tokens
  safeTake(gameBox, {
    guid = 'b79e45',
    position = { x = 26.5878448486328, y = 0.948099970817566, z = 0.89813619852066 },
    rotation = { x = -3.08809234184082E-07, y = -0.000170111568877473, z = 8.62816662561272E-08 }
  })
  -- Coercion Tokens
  safeTake(gameBox, {
    guid = 'aafd65',
    position = { x = 26.8213901519775, y = 0.948099911212921, z = 3.77403545379639 },
    rotation = { x = 6.92754866804535E-08, y = -6.89554362907074E-05, z = 1.79562192670346E-07 }
  })
  -- Tech
  safeTake(gameBox, {
    guid = 'ab2f29',
    position = { x = 22.5750541687012, y = 1.73926544189453, z = 5.85411643981934 },
    rotation = { x = -1.82649614544061E-06, y = -7.23076445865445E-05, z = 8.93736853413429E-08 }
  })
  -- Biological
  safeTake(gameBox, {
    guid = 'c20bf4',
    position = { x = 5.16443014144897, y = 1.73926508426666, z = 8.22421646118164 },
    rotation = { x = -5.32069236669486E-07, y = -3.06210422422737E-05, z = 9.45462108603579E-09 }
  })
  -- Tech
  safeTake(gameBox, {
    guid = 'bebd9a',
    position = { x = -22.5445938110352, y = 1.73926520347595, z = 5.97160959243774 },
    rotation = { x = -6.63864511807333E-07, y = -7.09742162143812E-05, z = -1.24105330456814E-08 }
  })
  -- Heavy Elements
  safeTake(gameBox, {
    guid = '782c40',
    position = { x = -21.8156337738037, y = 1.73926436901093, z = -6.92808818817139 },
    rotation = { x = -2.1785654098494E-06, y = -3.77026990463492E-05, z = -2.53573944064556E-07 }
  })
  -- Volatile
  safeTake(gameBox, {
    guid = '0cfdd6',
    position = { x = 5.12566518783569, y = 1.73926532268524, z = 10.5289764404297 },
    rotation = { x = -4.48778473582934E-06, y = -2.53196867561201E-05, z = -1.91646762459641E-07 }
  })
  -- Biological
  safeTake(gameBox, {
    guid = '0e2066',
    position = { x = -22.0155715942383, y = 1.73926424980164, z = -8.76255989074707 },
    rotation = { x = -5.94713628743193E-06, y = -3.41026643582154E-05, z = -2.94908687692441E-07 }
  })
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
    cards = { '45df75', '664491', 'f0a89d', '409ecd', 'dad860', '911e20', '1821f3','6cf398', 'c97347' }
    safeStore(cards, techDeck, function() gameBox.putObject(techDeck) end)
end

function storeBags(gameBox)
    -- Squad Boards
    currentObj = safeGet('1a9852')
    gameBox.putObject(currentObj)
    -- Chemicals
    currentObj = safeGet('657d69')
    gameBox.putObject(currentObj)
    -- Biological
    currentObj = safeGet('e1d805')
    gameBox.putObject(currentObj)
    -- Fire Tokens
    currentObj = safeGet('26cac4')
    gameBox.putObject(currentObj)
    -- Camp Tokens
    currentObj = safeGet('b79e45')
    gameBox.putObject(currentObj)
    -- Tech
    currentObj = safeGet('35fa01')
    gameBox.putObject(currentObj)
    -- Scrap
    currentObj = safeGet('5f986f')
    gameBox.putObject(currentObj)
    -- Coercion Tokens
    currentObj = safeGet('aafd65')
    gameBox.putObject(currentObj)
    -- Tech
    currentObj = safeGet('ab2f29')
    gameBox.putObject(currentObj)
    -- Biological
    currentObj = safeGet('c20bf4')
    gameBox.putObject(currentObj)
    -- Volatile
    currentObj = safeGet('0cfdd6')
    gameBox.putObject(currentObj)
    -- Heavy Elements
    currentObj = safeGet('782c40')
    gameBox.putObject(currentObj)
    -- Tech
    currentObj = safeGet('bebd9a')
    gameBox.putObject(currentObj)
    -- Biological
    currentObj = safeGet('0e2066')
    gameBox.putObject(currentObj)
end

function storePlayers(gameBox)
  playerStore(player1, gameBox)

  playerStore(player2, gameBox)

  playerStore(player3, gameBox)
end