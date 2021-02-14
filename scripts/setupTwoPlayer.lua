require("setupPlayer1")
require("setupPlayer2")

function setupTwoPlayer(gameBox)
  techDeck = getObjectFromGUID('35e89c')
  dealTwoPlayer(techDeck)

  p1Hand()
  p1HomeBase1()
  p1LesserFaction(4)

  p2Hand()
  p2HomeBase2()
  p2LesserFaction(3)
end

function dealTwoPlayer(techDeck)
  -- P-rifles
  safeTake(techDeck, {
    guid = '45df75',
    position = { x = 1.21173810958862, y = 1.40910482406616, z = 13.161865234375 },
    rotation = { x = 16.5244255065918, y = 359.896881103516, z = 359.970672607422 }
  })

  -- P-scanner
  safeTake(techDeck, {
    guid = '664491',
    position = { x = 3.46852898597717, y = 1.42439246177673, z = 13.0664472579956 },
    rotation = { x = 17.1446437835693, y = 0.0114705413579941, z = 0.000357135111698881 }
  })

  -- P-tools
  safeTake(techDeck, {
    guid = 'f0a89d',
    position = { x = 5.754723072052, y = 1.43597638607025, z = 13.0001955032349 },
    rotation = { x = 17.5920352935791, y = 359.947662353516, z = 359.983764648438 }
  })

  -- R-tools
  safeTake(techDeck, {
    guid = '409ecd',
    position = { x = -4.62264919281006, y = 0.973604738712311, z = -15.3960847854614 },
    rotation = { x = 1.13526220957283E-06, y = 179.98193359375, z = -5.20910703016852E-07 }
  })

  -- R-scanner
  safeTake(techDeck, {
    guid = 'dad860',
    position = { x = -2.19708466529846, y = 0.9736048579216, z = -15.4823808670044 },
    rotation = { x = 1.0888423958022E-06, y = 179.985702514648, z = 8.10850167454191E-07 }
  })

  -- R-rifles
  safeTake(techDeck, {
    guid = '911e20',
    position = { x = 0.0983505249023438, y = 0.9736048579216, z = -15.3319940567017 },
    rotation = { x = -5.19667537446367E-07, y = 179.985702514648, z = -2.70911499455906E-07 }
  })
end