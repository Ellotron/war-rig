function setupDice(gameBox)
      --
  safeTake(gameBox, {
    guid = 'edc0f7',
    position = { x = -27.4723587036133, y = 1.38233172893524, z = -0.312022894620895 },
    rotation = { x = 270, y = 96.9672241210938, z = 0 }
  })

  --
  safeTake(gameBox, {
    guid = '4f4bb6',
    position = { x = -27.26047706604, y = 1.29020023345947, z = -3.21176934242249 },
    rotation = { x = 90, y = 141.978805541992, z = 0 }
  })

  --
  safeTake(gameBox, {
    guid = 'ebab65',
    position = { x = -26.9128684997559, y = 1.38233315944672, z = -1.22776341438293 },
    rotation = { x = 26.5650424957275, y = 37.2033233642578, z = 143.999862670898 }
  })

  --
  safeTake(gameBox, {
    guid = '4b5767',
    position = { x = -27.6577262878418, y = 1.2901998758316, z = -3.93104124069214 },
    rotation = { x = 0, y = 123.899673461914, z = 270 }
  })

  --
  safeTake(gameBox, {
    guid = 'bb1b55',
    position = { x = -27.2361640930176, y = 1.38233125209808, z = 1.45689213275909 },
    rotation = { x = 26.5649242401123, y = 330.946868896484, z = 288.000030517578 }
  })

  --
  safeTake(gameBox, {
    guid = 'b90169',
    position = { x = -26.7100257873535, y = 1.29020059108734, z = -4.70948123931885 },
    rotation = { x = 90, y = 189.288131713867, z = 0 }
  })

  --
  safeTake(gameBox, {
    guid = '6e98b9',
    position = { x = -27.0920143127441, y = 1.29020047187805, z = -6.84810066223145 },
    rotation = { x = -6.75102114655601E-07, y = 227.325042724609, z = 1.0772662335512E-06 }
  })

  --
  safeTake(gameBox, {
    guid = '6e4dce',
    position = { x = -27.215856552124, y = 1.4032609462738, z = 3.39734196662903 },
    rotation = { x = 307.377288818359, y = 140.998718261719, z = 306.000061035156 }
  })

  --
  safeTake(gameBox, {
    guid = 'da8e28',
    position = { x = -27.721851348877, y = 1.38413083553314, z = 6.28397941589355 },
    rotation = { x = 319.397583007813, y = 357.849792480469, z = 159.784072875977 }
  })

  --
  safeTake(gameBox, {
    guid = '75656c',
    position = { x = -26.959867477417, y = 1.40326189994812, z = 4.4233832359314 },
    rotation = { x = 52.6226577758789, y = 71.4674224853516, z = 197.999984741211 }
  })

  --
  safeTake(gameBox, {
    guid = '842967',
    position = { x = -25.9161376953125, y = 1.58024430274963, z = 6.72187232971191 },
    rotation = { x = 345.834167480469, y = 322.676208496094, z = 205.603820800781 }
  })

  --
  safeTake(gameBox, {
    guid = '63d711',
    position = { x = -26.2772598266602, y = 1.43159794807434, z = 2.98163533210754 },
    rotation = { x = 302.262634277344, y = 62.4811172485352, z = 329.809173583984 }
  })

  --
  safeTake(gameBox, {
    guid = '786dc2',
    position = { x = -26.3274879455566, y = 1.33943009376526, z = 6.05038595199585 },
    rotation = { x = 324.338226318359, y = 102.836929321289, z = 355.612884521484 }
  })
end

function storeDice(gameBox)
      --
  currentObj = safeGet('bb1b55')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('da8e28')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('edc0f7')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('4f4bb6')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('4b5767')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('6e4dce')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('75656c')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('ebab65')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('b90169')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('63d711')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('6e98b9')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('842967')
  gameBox.putObject(currentObj)

  --
  currentObj = safeGet('786dc2')
  gameBox.putObject(currentObj)
end