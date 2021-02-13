function p1Store(gameBox)
    p1StoreHand(gameBox)
end

function p1StoreHand(gameBox)
  --
  currentObj = safeGet('ccc379')
  gameBox.putObject(currentObj)

 -- Purple 1
  currentObj = safeGet('b11235')
  gameBox.putObject(currentObj)

  -- Purple 6
  currentObj = safeGet('c8db9f')
  gameBox.putObject(currentObj)

  -- Purple 2
  currentObj = safeGet('663541')
  gameBox.putObject(currentObj)

  -- Purple 4
  currentObj = safeGet('e996d8')
  gameBox.putObject(currentObj)

  -- Purple 5
  currentObj = safeGet('34f7db')
  gameBox.putObject(currentObj)

  -- Purple 3
  currentObj = safeGet('739901')
  gameBox.putObject(currentObj)
end