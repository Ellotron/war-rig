function createButton(guid, label, functionName, position, size)
    position = position or {0,0.2,0}
    size = size or 500
    but = getObjectFromGUID(guid)
    but.createButton({
       click_function = functionName,
       function_owner = nil,
       label          = label,
       position       = position,
       rotation       = {0,0,0},
       width          = size,
       height         = size,
       font_size      = 200,
    })
end