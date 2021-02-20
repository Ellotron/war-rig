function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function safeGet(guid, shouldLog)
    obj = getObjectFromGUID(guid)
    if (obj == nil and shouldLog == true) then
     log(string.format('Object not found: %s', guid))
    end
    return obj
end

function safePlace(container, parameters)
    obj = safeGet(parameters.guid, false)
    if obj == nil then
        safeTake(container, parameters)
    else
        if parameters.position then
            obj.setPositionSmooth(parameters.position, false, false)
        end
        if parameters.rotation then
            obj.setRotationSmooth(parameters.rotation, false, false)
        end
        if parameters.callback_function then
            local objResting = function () return obj.resting end
            Wait.condition(parameters.callback_function, objResting, 10)
        end
    end
end

function safeTake(container, parameters)
    found = false
    for i, v in pairs(container.getObjects()) do
        if (v['guid'] == parameters['guid']) then
            found = true
            break
        end
    end
    if (found ~= true) then
        log(string.format('Object not found: %s', parameters['guid']))
    end
    return container.takeObject(parameters)
end

function safeStore(guidTable, store, next)
    objs = {}
    for i=1,tablelength(guidTable) do
        objs[i] = safeGet(guidTable[i], false)
        if objs[i] ~= nil then
            store.putObject(objs[i])
        end
    end
    objs[tablelength(objs)+1] = store
    if next ~= nil then
        local allResting = function ()
            for i=1,tablelength(objs) do
                if objs[i] ~= nil then
                    if objs[i].resting == false then
                        return false
                    end
                end
            end
            return true
        end
        Wait.condition(next, allResting);
    end
    return true;
end

function logScriptForSelectedObjects(f, player)
    log('==========')
    objs = Player[player or "White"].getSelectedObjects()
    for i, v in pairs(objs) do
        t = f(v)
        s = ''
        for i=1,tablelength(t) do s = string.format('%s\n%s', s, t[i]) end
        log(s)
    end
end

function scriptGuidList(v)
    return
    {
        string.format("  '%s',", v.getGUID()),
    }
end

function scriptStoreInGameBox(v)
    return
    {
        string.format('  -- %s', v.getName()),
        string.format("  currentObj = safeGet('%s')", v.getGUID()),
        '  gameBox.putObject(currentObj)'
    }
end

function scriptTakeObject(v)
    p = v.getPosition()
    r = v.getRotation()
    return
    {
        string.format('  -- %s', v.getName()),
        '  safeTake(gameBox, {',
        string.format("    guid = '%s',", v.getGUID()),
        string.format("    position = { x = %s, y = %s, z = %s },", p[1], p[2], p[3]),
        string.format("    rotation = { x = %s, y = %s, z = %s }", r[1], r[2], r[3]),
        '  })'
    }
end

function getInfo(player)
    log('==========')
    objs = Player[player or "White"].getSelectedObjects()
    for i, v in pairs(objs) do
        log(v.getTable(INFO_TABLE))
    end
end