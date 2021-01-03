function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function logScriptForSelectedObjects(player)
    log('==========')
    objs = Player[player or "White"].getSelectedObjects()
    for i, v in pairs(objs) do
        -- p = v.getPosition()
        -- r = v.getRotation()
        t =
        {
            string.format("-- %s", v.getName()),
            string.format("currentObj = getObjectFromGUID('%s'),", v.getGUID()),
            'gameBox.putObject(currentObj)',
        }
        s = ''
        for i=1,tablelength(t) do s = string.format('%s\n%s', s, t[i]) end
        log(s)
    end
end

function getInfo(player)
    log('==========')
    objs = Player[player or "White"].getSelectedObjects()
    for i, v in pairs(objs) do
        log(v.getTable(INFO_TABLE))
    end
end