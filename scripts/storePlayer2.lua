function p2Store(gameBox)
    p2StoreHand(gameBox)
end

function p2StoreHand(gameBox)
      -- Red 1
  currentObj = safeGet('fbfd3d')
  gameBox.putObject(currentObj)

  -- Red 2
  currentObj = safeGet('ab3b3d')
  gameBox.putObject(currentObj)

  -- Red 5
  currentObj = safeGet('d2bb62')
  gameBox.putObject(currentObj)

  -- Red 4
  currentObj = safeGet('cf32d3')
  gameBox.putObject(currentObj)

  -- Red 6
  currentObj = safeGet('358d93')
  gameBox.putObject(currentObj)

  -- Red 3
  currentObj = safeGet('0ddb43')
  gameBox.putObject(currentObj)

    --
    currentObj = safeGet('46edbb')
    gameBox.putObject(currentObj)
end