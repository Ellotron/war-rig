require("customProperties")

locationKey = 'Location'
whiteDiceGuid = '6e98b9'
dropGuids = {'68ae9c', 'd5ba72','4190d8'}

function empireInvasion()
    gameBox = safeGet('5578eb')
    readyDropships()
    -- place dice then drop ships
    safePlace(gameBox, {
        guid = whiteDiceGuid,
        position = { x = 0.0454534254968166, y = 5.08136487007141, z = -0.173489838838577 },
        callback_function = placeDropships
      })
end

function storeEmpire(gameBox)
    safeStore(dropGuids, gameBox)
end

function placeDropships()
    whiteDice = safeGet(whiteDiceGuid)
    local place3 = function () placeDropship(dropGuids[1]) end
    local place2 = function () placeDropship(dropGuids[2], place3) end
    placeDropship(dropGuids[3], place2)
end

function placeDropship(dropGuid, next)
    whiteDice.roll()
    local rollWatch = function() return whiteDice.resting end
    Wait.condition(function() dropShipTo(gameBox, dropGuid, whiteDice.getRotationValue(), next) end, rollWatch)
end

function readyDropships()
  safePlace(gameBox, {
    guid = dropGuids[1],
    position = { x = 30.2786998748779, y = 3.62151622772217, z = 3.9308660030365 },
    rotation = { x = -6.49254729978566E-07, y = 270.001983642578, z = 3.27353563989163E-06 },
    callback_function = function ()
        setCustomProperty(safeGet(dropGuids[1]), locationKey, nil)
    end
  })
  safePlace(gameBox, {
    guid = dropGuids[2],
    position = { x = 30.0279788970947, y = 3.62151598930359, z = -0.049568485468626 },
    rotation = { x = -1.13421208425279E-06, y = 270.001983642578, z = 1.67578866694384E-06 },
    callback_function = function ()
        setCustomProperty(safeGet(dropGuids[2]), locationKey, nil)
    end
  })
  safePlace(gameBox, {
    guid = dropGuids[3],
    position = { x = 30.2227401733398, y = 3.62151622772217, z = -3.53186249732971 },
    rotation = { x = -5.60250498438108E-07, y = 270.001983642578, z = 6.03195348958252E-06 },
    callback_function = function ()
        setCustomProperty(safeGet(dropGuids[3]), locationKey, nil)
    end
  })
end

function markLocationAnd(dropGuid, location, next)
    setCustomProperty(safeGet(dropGuid), locationKey, location)
    if next then
        next()
    end
end

function isViableLocation(location)
    for i=1,tablelength(dropGuids) do
        local takenLocation = getCustomProperty(safeGet(dropGuids[i]), locationKey)
        if takenLocation == location then
            return false
        end
    end
    return true
end

function getViableLocation(location)
    firstLocation = location
    while isViableLocation(location) == false do
        location = location + 1
        if location > 6 then
            location = 1
        end
        if location == firstLocation then
            print("No viable drop-ship location")
            return 0;
        end
    end
    return location
end

function dropShipTo(gameBox, dropGuid, roll, next)
    roll = getViableLocation(roll)
    parameters = {
        guid = dropGuid,
        callback_function = function ()
            markLocationAnd(dropGuid, roll, next)
        end
    }
    if roll == 1 then
        parameters.position = { x = 16.2318935394287, y = 1.75116491317749, z = 5.92401170730591 }
        parameters.rotation = { x = 4.69484120912966E-06, y = 270.001983642578, z = 3.97709936805768E-06 }
    elseif roll == 2 then
        parameters.position = { x = -18.1421585083008, y = 1.75116395950317, z = -6.50943899154663 }
        parameters.rotation = { x = 3.20828030453413E-06, y = 270.001983642578, z = 6.85136728861835E-06 }
    elseif roll == 3 then
        parameters.position = { x = 0.0830651372671127, y = 1.75116419792175, z = -8.20090198516846 }
        parameters.rotation = { x = 1.13786845759023E-05, y = 270.001983642578, z = 2.09512518267729E-06 }
    elseif roll == 4 then
        parameters.position = { x = -0.573902368545532, y = 1.75116527080536, z = 6.95097208023071 }
        parameters.rotation = { x = 7.28399527361034E-06, y = 270.001983642578, z = -1.82461315034743E-06 }
    elseif roll == 5 then
        parameters.position = { x = -17.9831886291504, y = 1.75116515159607, z = 5.49160575866699 }
        parameters.rotation = { x = 8.21960202301852E-06, y = 270.001983642578, z = -1.65031178767094E-06 }
    elseif roll == 6 then
        parameters.position = { x = 17.8370018005371, y = 1.75116372108459, z = -7.45076465606689 }
        parameters.rotation = { x = 1.03328429759131E-05, y = 270.001983642578, z = -3.16257592203328E-06 }
    else
        return
    end
    safePlace(gameBox, parameters)
end