require("constants")
infinitePowerPieces = {
  -- Infinite Power Facility
  {
    guid = '4803ba',
    position = { x = 21.7910804748535, y = 1.75130760669708, z = 8.26620483398438 },
    rotation = { x = -3.00893725579954E-06, y = -0.00498931389302015, z = 1.3088290415908E-06 }
  },
  -- Player 1 Power
  {
    guid = '852620',
    position = { x = 3.56299471855164, y = 0.774966061115265, z = 16.1213550567627 },
    rotation = { x = 6.36495042272145E-06, y = 0.00133378116879612, z = -1.16652785209226E-07 }
  },
  -- Player 2 Power
  {
    guid = 'd4797c',
    position = { x = 3.78864550590515, y = 0.774965763092041, z = -15.232892036438 },
    rotation = { x = -7.09239245111348E-08, y = 315.007019042969, z = -7.79210154178145E-07 }
  },
  -- Player 3 Power
  {
    guid = '69ac4b',
    position = { x = 26.3518218994141, y = 0.77496600151062, z = -14.7386465072632 },
    rotation = { x = -2.15110858903245E-07, y = 5.3074039897183E-05, z = -1.61750193683474E-07 }
  },
  -- Player 4 Power
  {
    guid = '2ba962',
    position = { x = -13.7563228607178, y = 0.774965941905975, z = 17.3585205078125 },
    rotation = { x = -4.40216865627008E-07, y = -0.000832369201816618, z = 1.39739029236807E-06 }
  },
}

function deployInfinitePower(numberOfPlayers)
require("customProperties")
    broadcastToAll("Infinite power discovered! Political sway could decide the game!", ALERT_COLOUR)
    safePlace(gameBox, infinitePowerPieces[1])
    safePlace(gameBox, infinitePowerPieces[2])
    safePlace(gameBox, infinitePowerPieces[3])
    if numberOfPlayers > 2 then
        safePlace(gameBox, infinitePowerPieces[4])
    end
    if numberOfPlayers > 3 then
      safePlace(gameBox, infinitePowerPieces[5])
    end
end

function storeInfinite(gameBox)
  safeStore(infinitePowerPieces, gameBox)
end