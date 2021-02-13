require("utilities")
require("setupDice")
require("setupTwoPlayer")
require("storePlayer1")
require("storePlayer2")

function createButton(guid, label, functionName, position, size)
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
       font_size      = 200,
    })
end


function setup2()
    gameBox = safeGet('5578eb')
    setupBags(gameBox)
    setupDice(gameBox)
    setupTwoPlayer(gameBox)
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

function storeInBox()
    gameBox = safeGet('5578eb')
    storeBags(gameBox)
    storeDice(gameBox)
    storeDecks(gameBox)
    storePlayers(gameBox)
end

function storeDecks(gameBox)
    -- Tech Deck
    techDeck = safeGet('35e89c')
    currentObj = safeGet('45df75')
    techDeck.putObject(currentObj)
    currentObj = safeGet('664491')
    techDeck.putObject(currentObj)
    currentObj = safeGet('f0a89d')
    techDeck.putObject(currentObj)
    currentObj = safeGet('409ecd')
    techDeck.putObject(currentObj)
    currentObj = safeGet('dad860')
    techDeck.putObject(currentObj)
    currentObj = safeGet('911e20')
    techDeck.putObject(currentObj)
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
  p1Store(gameBox)

  p2Store(gameBox)
  --
  currentObj = safeGet('10f853')
  gameBox.putObject(currentObj)

  -- P War Rig
  currentObj = safeGet('4c65be')
  gameBox.putObject(currentObj)

  -- P2-1
  currentObj = safeGet('b61975')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('bb1fd3')
  gameBox.putObject(currentObj)

  -- P1-1
  currentObj = safeGet('3e4207')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('cf437f')
  gameBox.putObject(currentObj)

  -- P3-1
  currentObj = safeGet('44828b')
  gameBox.putObject(currentObj)

  -- P4-1
  currentObj = safeGet('54ae83')
  gameBox.putObject(currentObj)

  -- P5-1
  currentObj = safeGet('09a1b1')
  gameBox.putObject(currentObj)

  -- P6-1
  currentObj = safeGet('880f43')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('3bb1a3')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('e02066')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('2a4264')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('b7b878')
  gameBox.putObject(currentObj)

  -- R War Rig
  currentObj = safeGet('9019fc')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('51358a')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('6b2997')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('23ea3d')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('20401a')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('84c0c3')
  gameBox.putObject(currentObj)
end