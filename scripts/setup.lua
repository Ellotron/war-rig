require("setupTwoPlayer")

function createButton(guid, label, functionName, position, size)
    position = position or {0,0.2,0}
    size = size or 500
    but = getObjectFromGUID(guid)
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
    gameBox = getObjectFromGUID('5578eb')
    setupBags(gameBox)
    setupDecks(gameBox)
    setupTwoPlayer(gameBox)
end

function setupDecks(gameBox)
    -- Tech Deck
    gameBox.takeObject({
        guid = '35e89c',
        position = { x = -11.8115749359131, y = 2.02723932266235, z = 0.642256796360016 },
        rotation = { x = 6.92669391355594E-06, y = 180.02424621582, z = 180 }
    })
end

function setupBags(gameBox)
    -- Squad Boards
    gameBox.takeObject({
        guid = '1a9852',
        position = { x = 26.9216613769531, y = 0.948099672794342, z = 6.83267879486084 },
        rotation = { x = 2.84003181150183E-06, y = -9.72201305557974E-05, z = 1.66527695455443E-06 }
    })
    -- Biological
    gameBox.takeObject({
    guid = 'e1d805',
    position = { x = 22.8184547424316, y = 1.73926436901093, z = -8.26023960113525 },
    rotation = { x = -5.15348619956058E-06, y = -3.20392573485151E-05, z = -3.79103752834453E-08 }
  })
  -- Chemicals
  gameBox.takeObject({
    guid = '657d69',
    position = { x = 22.7814159393311, y = 1.73926436901093, z = -5.74489068984985 },
    rotation = { x = -6.49826688459143E-07, y = -3.24362990795635E-05, z = -5.19074433213973E-07 }
  })
  -- Fire Tokens
  gameBox.takeObject({
    guid = '26cac4',
    position = { x = 26.6121196746826, y = 0.948099970817566, z = -2.10684680938721 },
    rotation = { x = -1.44787393185908E-09, y = -6.17518526269123E-05, z = 7.77094015802504E-08 }
  })
  -- Tech
  gameBox.takeObject({
    guid = '35fa01',
    position = { x = 4.25365543365479, y = 1.73926401138306, z = -9.77801418304443 },
    rotation = { x = -6.31945795248612E-06, y = -6.79706281516701E-05, z = -3.56705101012267E-07 }
  })
  -- Scrap
  gameBox.takeObject({
    guid = '5f986f',
    position = { x = 4.945228099823, y = 1.73926472663879, z = 0.0404360517859459 },
    rotation = { x = -1.89839954600757E-06, y = -6.1837286921218E-05, z = -3.25284389646185E-07 }
  })
  -- Camp Tokens
  gameBox.takeObject({
    guid = 'b79e45',
    position = { x = 26.5878448486328, y = 0.948099970817566, z = 0.89813619852066 },
    rotation = { x = -3.08809234184082E-07, y = -0.000170111568877473, z = 8.62816662561272E-08 }
  })
  -- Coercion Tokens
  gameBox.takeObject({
    guid = 'aafd65',
    position = { x = 26.8213901519775, y = 0.948099911212921, z = 3.77403545379639 },
    rotation = { x = 6.92754866804535E-08, y = -6.89554362907074E-05, z = 1.79562192670346E-07 }
  })
  -- Tech
  gameBox.takeObject({
    guid = 'ab2f29',
    position = { x = 22.5750541687012, y = 1.73926544189453, z = 5.85411643981934 },
    rotation = { x = -1.82649614544061E-06, y = -7.23076445865445E-05, z = 8.93736853413429E-08 }
  })
  -- Biological
  gameBox.takeObject({
    guid = 'c20bf4',
    position = { x = 5.16443014144897, y = 1.73926508426666, z = 8.22421646118164 },
    rotation = { x = -5.32069236669486E-07, y = -3.06210422422737E-05, z = 9.45462108603579E-09 }
  })
  -- Tech
  gameBox.takeObject({
    guid = 'bebd9a',
    position = { x = -22.5445938110352, y = 1.73926520347595, z = 5.97160959243774 },
    rotation = { x = -6.63864511807333E-07, y = -7.09742162143812E-05, z = -1.24105330456814E-08 }
  })
  -- Heavy Elements
  gameBox.takeObject({
    guid = '782c40',
    position = { x = -21.8156337738037, y = 1.73926436901093, z = -6.92808818817139 },
    rotation = { x = -2.1785654098494E-06, y = -3.77026990463492E-05, z = -2.53573944064556E-07 }
  })
  -- Volatile
  gameBox.takeObject({
    guid = '0cfdd6',
    position = { x = 5.12566518783569, y = 1.73926532268524, z = 10.5289764404297 },
    rotation = { x = -4.48778473582934E-06, y = -2.53196867561201E-05, z = -1.91646762459641E-07 }
  })
  -- Biological
  gameBox.takeObject({
    guid = '0e2066',
    position = { x = -22.0155715942383, y = 1.73926424980164, z = -8.76255989074707 },
    rotation = { x = -5.94713628743193E-06, y = -3.41026643582154E-05, z = -2.94908687692441E-07 }
  })
end

function storeInBox()
    gameBox = getObjectFromGUID('5578eb')
    storeBags(gameBox)
    storeDecks(gameBox)
    storePlayers(gameBox)
end

function storeDecks(gameBox)
    -- Tech Deck
    currentObj = getObjectFromGUID('35e89c')
    gameBox.putObject(currentObj)
end

function storeBags(gameBox)
    -- Squad Boards
    currentObj = getObjectFromGUID('1a9852')
    gameBox.putObject(currentObj)
    -- Chemicals
    currentObj = getObjectFromGUID('657d69')
    gameBox.putObject(currentObj)
    -- Biological
    currentObj = getObjectFromGUID('e1d805')
    gameBox.putObject(currentObj)
    -- Fire Tokens
    currentObj = getObjectFromGUID('26cac4')
    gameBox.putObject(currentObj)
    -- Camp Tokens
    currentObj = getObjectFromGUID('b79e45')
    gameBox.putObject(currentObj)
    -- Tech
    currentObj = getObjectFromGUID('35fa01')
    gameBox.putObject(currentObj)
    -- Scrap
    currentObj = getObjectFromGUID('5f986f')
    gameBox.putObject(currentObj)
    -- Coercion Tokens
    currentObj = getObjectFromGUID('aafd65')
    gameBox.putObject(currentObj)
    -- Tech
    currentObj = getObjectFromGUID('ab2f29')
    gameBox.putObject(currentObj)
    -- Biological
    currentObj = getObjectFromGUID('c20bf4')
    gameBox.putObject(currentObj)
    -- Volatile
    currentObj = getObjectFromGUID('0cfdd6')
    gameBox.putObject(currentObj)
    -- Heavy Elements
    currentObj = getObjectFromGUID('782c40')
    gameBox.putObject(currentObj)
    -- Tech
    currentObj = getObjectFromGUID('bebd9a')
    gameBox.putObject(currentObj)
    -- Biological
    currentObj = getObjectFromGUID('0e2066')
    gameBox.putObject(currentObj)
end

function storePlayers(gameBox)
  --
  currentObj = getObjectFromGUID('10f853')
  gameBox.putObject(currentObj)

  -- P War Rig
  currentObj = getObjectFromGUID('4c65be')
  gameBox.putObject(currentObj)

  -- P1-4
  currentObj = getObjectFromGUID('98fb5c')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('f57fb2')
  gameBox.putObject(currentObj)

  -- P2-1
  currentObj = getObjectFromGUID('b61975')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('a90f1b')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('ee2276')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('bb1fd3')
  gameBox.putObject(currentObj)

  -- P1-1
  currentObj = getObjectFromGUID('3e4207')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('cf437f')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('73ffa4')
  gameBox.putObject(currentObj)

  -- P3-1
  currentObj = getObjectFromGUID('44828b')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('ccc379')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('570051')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('5f8679')
  gameBox.putObject(currentObj)

  -- P4-1
  currentObj = getObjectFromGUID('54ae83')
  gameBox.putObject(currentObj)

  -- P5-1
  currentObj = getObjectFromGUID('09a1b1')
  gameBox.putObject(currentObj)

  -- P6-1
  currentObj = getObjectFromGUID('880f43')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('8c714e')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('8d7fe3')
  gameBox.putObject(currentObj)
  --
  currentObj = getObjectFromGUID('46edbb')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('2c1447')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('6e4072')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('30e4e8')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('3bb1a3')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('e02066')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('2a4264')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('b7b878')
  gameBox.putObject(currentObj)

  -- R War Rig
  currentObj = getObjectFromGUID('9019fc')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('51358a')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('6b2997')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('5504ef')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('5fc651')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('ed939d')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('719256')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('5496b1')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('9eed07')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('23ea3d')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('20401a')
  gameBox.putObject(currentObj)

  --
  currentObj = getObjectFromGUID('84c0c3')
  gameBox.putObject(currentObj)
end