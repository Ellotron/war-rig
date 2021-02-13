require("setupPlayer1")
require("setupPlayer2")

function setupTwoPlayer(gameBox)
  techDeck = getObjectFromGUID('35e89c')
  dealTwoPlayer(techDeck)
  p1HomeBase1()
  p1LesserFaction(4)
  p2HomeBase2()
  p2LesserFaction(3)
  --
  safeTake(gameBox, {
    guid = '46edbb',
    position = { x = 4.56795835494995, y = 1.41273319721222, z = -14.614595413208 },
    rotation = { x = 7.27185821533203, y = 180.016494750977, z = -1.96402070287149E-05 }
  })
  --
  safeTake(gameBox, {
    guid = 'ccc379',
    position = { x = -6.68559074401855, y = 1.41631150245667, z = 14.5665473937988 },
    rotation = { x = 7.32344341278076, y = 0.0149995042011142, z = 0.000732915825210512 }
  })
end

function dealTwoPlayer(techDeck)
  -- P-rifles
  safeTake(techDeck, {
    guid = '45df75',
    position = { x = -2.56603145599365, y = 0.973604738712311, z = 14.8161840438843 },
    rotation = { x = 6.49140019959304E-07, y = 0.0324463322758675, z = 5.17515331921459E-07 }
  })

  -- P-scanner
  safeTake(techDeck, {
    guid = '664491',
    position = { x = -0.0397311970591545, y = 0.973604738712311, z = 14.6915321350098 },
    rotation = { x = 3.97144418684547E-07, y = 0.0324452668428421, z = -3.7199419011813E-07 }
  })

  -- P-tools
  safeTake(techDeck, {
    guid = 'f0a89d',
    position = { x = 2.38597130775452, y = 0.973604738712311, z = 14.7408514022827 },
    rotation = { x = 1.2854289934694E-06, y = 0.0279384162276983, z = 1.60517174663255E-07 }
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