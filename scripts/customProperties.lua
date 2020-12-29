require("constants")
function getCustomProperty(object, key)
    t = object.getTable(INFO_TABLE)
    if t == nil then
        return nil
    end
    return t[key]
end

function setCustomProperty(object, key, value)
    t = object.getTable(INFO_TABLE)
    if t == nil then
        t = {}
    end
    t[key] = value
    object.setTable(INFO_TABLE, t)
end