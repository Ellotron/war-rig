function p1Hand(gameBox, techDeck)
  -- war rig card
  safeTake(gameBox, {
    guid = 'ccc379',
    position = { x = 17.6636505126953, y = 1.37655484676361, z = 14.9224767684937 },
    rotation = { x = 7.21038389205933, y = 0.0187978595495224, z = 0.00266618141904473 }
  })
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
    -- Purple 1
    safeTake(gameBox, {
        guid = 'b11235',
        position = { x = 12.629322052002, y = 0.948099792003632, z = 13.5175361633301 },
        rotation = { x = 4.25666087267018E-07, y = 1.71948959177826E-05, z = 2.42028733055122E-07 }
      })

      -- Purple 2
      safeTake(gameBox, {
        guid = '663541',
        position = { x = 10.368257522583, y = 0.948099613189697, z = 13.4657506942749 },
        rotation = { x = -1.60470772243571E-05, y = 359.971984863281, z = -5.85453017265536E-06 }
      })

      -- Purple 5
      safeTake(gameBox, {
        guid = '34f7db',
        position = { x = 10.4876518249512, y = 0.948099911212921, z = 15.1622171401978 },
        rotation = { x = -3.2407311323368E-07, y = -2.84340749203693E-05, z = 1.15397949684848E-06 }
      })

      -- Purple 3
      safeTake(gameBox, {
        guid = '739901',
        position = { x = 8.21600151062012, y = 0.948100090026855, z = 13.5694150924683 },
        rotation = { x = -1.09308973605948E-06, y = -1.30440844259283E-06, z = -6.70083750264894E-07 }
      })

      -- Purple 6
      safeTake(gameBox, {
        guid = 'c8db9f',
        position = { x = 8.51503086090088, y = 0.948099970817566, z = 15.1688604354858 },
        rotation = { x = 1.01341902336571E-06, y = -3.97263393097091E-05, z = 1.18273715088435E-06 }
      })

      -- Purple 4
      safeTake(gameBox, {
        guid = 'e996d8',
        position = { x = 12.595401763916, y = 0.948099851608276, z = 15.3586149215698 },
        rotation = { x = -2.4927091999416E-06, y = -9.46895033848705E-06, z = -5.88856846661656E-06 }
      })
end

function p1LesserFaction(destinationBase, gameBox)
    if (destinationBase == 4) then
        -- P6-1
        safeTake(gameBox, {
            guid = '880f43',
            position = { x = -13.9747552871704, y = 1.80116534233093, z = 8.49347686767578 },
            rotation = { x = 1.76389221451245E-05, y = 0.0371186621487141, z = 180 }
        })

        -- P4-1
        safeTake(gameBox, {
            guid = '54ae83',
            position = { x = -12.8925762176514, y = 1.80116534233093, z = 6.81903839111328 },
            rotation = { x = -1.08036124402133E-06, y = 359.993438720703, z = 180 }
        })

        -- P5-1
        safeTake(gameBox, {
            guid = '09a1b1',
            position = { x = -11.8979339599609, y = 1.80116534233093, z = 8.61107730865479 },
            rotation = { x = -2.02003448066534E-05, y = 0.00264669861644506, z = 180 }
        })
    end
    if destinationBase == 6 then
        -- P6-1
        safeTake(gameBox, {
          guid = '880f43',
          position = { x = 17.5578708648682, y = 1.80116498470306, z = 1.4036511182785 },
          rotation = { x = 7.75255648477469E-06, y = 0.0334337763488293, z = 180 }
        })

        -- P5-1
        safeTake(gameBox, {
          guid = '09a1b1',
          position = { x = 19.6346912384033, y = 1.80116510391235, z = 1.52125334739685 },
          rotation = { x = -7.48338425182737E-06, y = 0.00262279249727726, z = 180.000015258789 }
        })

        -- P4-1
        safeTake(gameBox, {
          guid = '54ae83',
          position = { x = 18.6400489807129, y = 1.80116486549377, z = -0.270787417888641 },
          rotation = { x = -2.34928074860363E-06, y = 359.989135742188, z = 180 }
        })
    end
end

function p1HomeBase1(gameBox)

  --
  safeTake(gameBox, {
    guid = 'cf437f',
    position = { x = 8.839599609375, y = 1.89117991924286, z = 10.2313919067383 },
    rotation = { x = -0.000383221195079386, y = 0.550319850444794, z = 180.000183105469 }
  })

  -- P War Rig
  safeTake(gameBox, {
    guid = '4c65be',
    position = { x = 12.5218629837036, y = 1.91522860527039, z = 10.5660467147827 },
    rotation = { x = -3.50004984284169E-06, y = 45.0212821960449, z = -4.51064715889515E-06 }
  })

  -- P3-1
  safeTake(gameBox, {
    guid = '44828b',
    position = { x = 7.6932430267334, y = 1.94107663631439, z = 9.20827198028564 },
    rotation = { x = -0.00196630787104368, y = 1.21083056926727, z = 180.001312255859 }
  })

  --
  safeTake(gameBox, {
    guid = '10f853',
    position = { x = 12.3047437667847, y = 1.89114761352539, z = 6.63752365112305 },
    rotation = { x = 0.000352993432898074, y = 0.279265910387039, z = 179.999313354492 }
  })

  -- P1-1
  safeTake(gameBox, {
    guid = '3e4207',
    position = { x = 7.77677345275879, y = 1.94099497795105, z = 5.18696212768555 },
    rotation = { x = -0.000312448682961985, y = 358.586456298828, z = 180.004150390625 }
  })

  --
  safeTake(gameBox, {
    guid = 'bb1fd3',
    position = { x = 9.10872745513916, y = 1.89117336273193, z = 6.44783926010132 },
    rotation = { x = -5.16286636411678E-05, y = 0.56976044178009, z = 179.999740600586 }
  })

  -- P2-1
  safeTake(gameBox, {
    guid = 'b61975',
    position = { x = 11.1594009399414, y = 1.94113063812256, z = 5.58904504776001 },
    rotation = { x = 0.000457693182397634, y = 359.663299560547, z = 180.000961303711 }
  })
end