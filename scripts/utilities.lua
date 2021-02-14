function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function safeGet(guid)
    obj = getObjectFromGUID(guid)
    if (obj == nil) then
     log(string.format('Object not found: %s', guid))
    end
    return obj
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

function logScriptForSelectedObjects(f, player)
    log('==========')
    objs = Player[player or "Red"].getSelectedObjects()
    for i, v in pairs(objs) do
        t = f(v)
        s = ''
        for i=1,tablelength(t) do s = string.format('%s\n%s', s, t[i]) end
        log(s)
    end
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