function p2Store(gameBox) p2StoreHand(gameBox) end

function p2StoreHand(gameBox)
    safeStore({
        'fbfd3d', 'ab3b3d', 'd2bb62', 'cf32d3', '358d93', '0ddb43', '46edbb'
    }, gameBox)
end

function p2Hand(gameBox, techDeck)
  -- war rig card
  safeTake(gameBox, {
    guid = '46edbb',
    position = { x = -16.2996025085449, y = 1.37534189224243, z = -14.9394216537476 },
    rotation = { x = 7.19183397293091, y = 180.030960083008, z = 0.000955622410401702 }
  })
  -- Red 1
  safeTake(gameBox, {
    guid = 'fbfd3d',
    position = { x = -11.4566640853882, y = 0.948099792003632, z = -14.3369598388672 },
    rotation = { x = 3.91567205326737E-08, y = -4.64968397864141E-05, z = -1.48902017826913E-07 }
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
  -- Red 2
  safeTake(gameBox, {
    guid = 'ab3b3d',
    position = { x = -9.64443778991699, y = 0.948099792003632, z = -14.1481475830078 },
    rotation = { x = -3.71716538438704E-07, y = -4.64987933810335E-05, z = 1.42374174672E-08 }
  })

  -- Red 3
  safeTake(gameBox, {
    guid = '0ddb43',
    position = { x = -7.94543075561523, y = 0.948099792003632, z = -14.179235458374 },
    rotation = { x = -7.62199334758407E-08, y = -4.65159391751513E-05, z = -3.49214957395816E-07 }
  })

  -- Red 6
  safeTake(gameBox, {
    guid = '358d93',
    position = { x = -7.87616205215454, y = 0.948099792003632, z = -15.8417530059814 },
    rotation = { x = 1.44674493185448E-06, y = -4.68278194603045E-05, z = -6.37302889572311E-07 }
  })

  -- Red 5
  safeTake(gameBox, {
    guid = 'd2bb62',
    position = { x = -9.63839817047119, y = 0.948099672794342, z = -15.9857301712036 },
    rotation = { x = -1.63607836611845E-07, y = -4.6476397983497E-05, z = 3.27711660474961E-07 }
  })

  -- Red 4
  safeTake(gameBox, {
    guid = 'cf32d3',
    position = { x = -11.2889881134033, y = 0.948099792003632, z = -16.0943965911865 },
    rotation = { x = 4.25458580366467E-07, y = -4.65081393485889E-05, z = -6.36663628483802E-08 }
  })
end

function p2LesserFaction(destinationBase, gameBox)
  if (destinationBase == 3) then
    --
    safeTake(gameBox, {
        guid = '20401a',
        position = { x = 7.56989192962646, y = 1.80116438865662, z = -6.57533359527588 },
        rotation = { x = 4.2123174353037E-06, y = 180.000289916992, z = 179.999954223633 }
    })
    --
    safeTake(gameBox, {
        guid = '84c0c3',
        position = { x = 9.00802421569824, y = 1.80118846893311, z = -7.44775772094727 },
        rotation = { x = -0.00494085112586617, y = 179.863250732422, z = 180.007583618164 }
    })
    --
    safeTake(gameBox, {
        guid = '23ea3d',
        position = { x = 8.06408977508545, y = 1.81063890457153, z = -8.01418495178223 },
        rotation = { x = 0.869659602642059, y = 182.035278320313, z = 179.464920043945 }
    })
    end
    if (destinationBase == 5) then
        --
      safeTake(gameBox, {
        guid = '20401a',
        position = { x = -19.5109596252441, y = 1.80116486549377, z = 2.10709547996521 },
        rotation = { x = 3.86204283131519E-06, y = 180.001022338867, z = 180 }
      })
      --
      safeTake(gameBox, {
        guid = '23ea3d',
        position = { x = -19.2998600006104, y = 1.80116498470306, z = 0.558988332748413 },
        rotation = { x = 4.33949344369466E-06, y = 179.965469360352, z = 180 }
      })
      --
      safeTake(gameBox, {
        guid = '84c0c3',
        position = { x = -18.0728282928467, y = 1.80116486549377, z = 1.23467087745667 },
        rotation = { x = 1.48507706398959E-05, y = 179.983215332031, z = 180 }
      })
    end
end

function p2HomeBase2(gameBox)
  -- Squad 1
  safeTake(gameBox, {
    guid = '3bb1a3',
    position = { x = -10.3732509613037, y = 1.89118051528931, z = -6.02188062667847 },
    rotation = { x = -0.000272789853625, y = 179.822814941406, z = 180.000335693359 },
    callback_function = function ()
      safeTake(gameBox, {
        guid = '2a4264',
        position = { x = -9.24506855010986, y = 1.94112229347229, z = -4.97375726699829 },
        rotation = { x = -0.00394915556535125, y = 180.047210693359, z = 180.005111694336 }
      })
    end
  })

  -- Squad 3
  safeTake(gameBox, {
    guid = '51358a',
    position = { x = -7.44169092178345, y = 1.89117658138275, z = -10.3735637664795 },
    rotation = { x = -0.000243998103542253, y = 179.813003540039, z = 180.000228881836 },
    callback_function = function()
      safeTake(gameBox, {
        guid = 'b7b878',
        position = { x = -6.31375408172607, y = 1.94111895561218, z = -9.32722091674805 },
        rotation = { x = -0.000226998192374595, y = 180.231323242188, z = 180.000122070313 }
      })
    end
  })

  -- R War Rig
  safeTake(gameBox, {
    guid = '05711e',
    position = { x = -11.7499866485596, y = 1.91522669792175, z = -10.0964107513428 },
    rotation = { x = 4.83588792121736E-06, y = 224.972305297852, z = 3.92828360418207E-06 }
  })

  -- Squad 2
  safeTake(gameBox, {
    guid = 'e02066',
    position = { x = -6.82895612716675, y = 1.89118123054504, z = -6.37661075592041 },
    rotation = { x = -0.000441251671873033, y = 180.707885742188, z = 180.000137329102 },
    callback_function = function()
      safeTake(gameBox, {
        guid = '6b2997',
        position = { x = -5.70221042633057, y = 1.94102370738983, z = -5.31997966766357 },
        rotation = { x = -0.00332805537618697, y = 179.463775634766, z = 180.003509521484 }
      })
    end
  })
end